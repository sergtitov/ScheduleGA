{$H-}   // string = ShortString
unit tc;

interface

Uses SysUtils, classes, math, comctrls, windows, dialogs, forms;

type
  time = real;
  massa = real;
const
   eps = 1e-5;    // погрешность
   step : time = 60; // шаг обработки (сек)
   //  количество чисел с равномерным распределением, используемых для генерации
   //  одного числа из нормального распределения
   NORMAL_MAX_NUMBERS = 12;
   //  максимальное поддерживаемое количество типов сырья
   MAX_MATERIALS = 255;
   MAX_TIME : time = $FFFFFFFF;
   MAX_POINTS = 100;
resourcestring
  mCantDeleteMaterial = 'Нельзя удалять этот тип сырья, т.к. на него '{#13} +
                        'ссыляется линия обработки';
  mCantDeleteLine     = 'Нельзя удалять эту линию, т.к. на нее '{#13} +
                        'ссыляется бункер';

  SaveSuccesfully = 'Модель успешно записана на диск!';
  LoadSuccesfully = 'Модель успешно загружена!';
  NoLink = 'Нет соответствия';
  mNoMaterials = '(Типы сырья не заданы)';

  CAPT = 'Моделирование';
  NO_NAME = 'Без имени';
  MSG_BAD_MODEL = 'При создании линии модель не определена';
  MSG_NOT_FLOAT = 'Необходимо ввести число';
type
   EBadModel = class(Exception)
       constructor Create;
   end;

   ENotFloat = class(Exception)
       constructor Create;
   end;



//  типы узлов и листьев дерева
TNodeType = (
               ntModelFolder,    //  папка модели
               ntBunkerFolder,   //  папка бункеров
               ntCommFolder,     //  папка коммерческих бункеров
               ntGivenFolder,    //  папка давальческих бункеров
               ntLineFolder,     //  папка линий обработки
               ntMaterialFolder, //  папка типов сырья
               ntAllTime,        //  лист времени моделирования
               ntBunker,         //  лист бункера
               ntLine,           //  лист линии обработки
               ntMaterial        //  лист типа сырья
            );

//  Структура данных о сущности узла или листа дерева.
//  На эту структуру будет ссыляться указатель Data узла.
TNodeData = record
   //  тип узла или листа дерева
   NodeType : TNodeType;
   //  указатель на соответствующий объект модели
   LinkedObject : TObject;
end;



TListObject = class;
TModel = class;
TListBunker = class;
TListAssembleLine = class;
TListMaterial = class;
TReconfigure = class;
TReconfList = class;

TEqualFunction = function (AObject : TObject) : boolean;
       //  это именно тот объект, который мы ищем ?
TCompareFunction = function (AObject1, AObject2 : TObject) : integer;
    //  возврящает значение < 0, если первый меньше второго, 0 если равны
    //  и больше нуля, если первый больше второго

TObjectArray = array of TListObject;

//  Список объектов. Реализует хранение, поиск, сортировку любых объектов
TObjectList = class(TObject)
   private
      FList : TObjectArray;    //  массив объектов
      Model : TModel;
   public
      procedure Clear;

      procedure Save(var Mem : TMemoryStream);
      procedure Load(var Mem : TMemoryStream);virtual;abstract;
      procedure Prepare;virtual;

      function GetCount : integer;

      procedure Append(value : TListObject);    //  добавляет объект в конец
      procedure Delete(index : integer);virtual;    //  удаляет объект с индексом index

      //  вставляет объект после объекта с индексом after
      //  after = -1 вставить перед первым
      procedure Insert(after : integer; value : TListObject);virtual;
      //  ищет объект пересмотром всех объектов и возвращает его индекс
      function  FindObject(equal : TEqualFunction) : integer;
      //  сортирует объекты в списке, используя пользовательскую функцию сравнения
      procedure Sort(compare : TCompareFunction);

      constructor Create(AModel : TModel);
      destructor Destroy;override;

      property Count : integer read GetCount;
      property List : TObjectArray read FList;
end;


//  объект списка
TListObject = class
   private
     //  ссылка на список, содержащий данный объект
     FObjectList : TObjectList;
   public
      Name : string;

      procedure Load(var mem : TMemoryStream);virtual;abstract;
      procedure Save(var mem : TMemoryStream);virtual;abstract;
      procedure Prepare;virtual;abstract;

      constructor Create(ObjList : TObjectList);virtual;

      property ObjectList : TObjectList read FObjectList;
end;

//  Модель
TModel = class
   private
      FCommBunkers,
      FGivenBunkers   : TListBunker;   //  список бункеров
      FLines     : TListAssembleLine;  //  список линий обработки
      FMaterials : TListMaterial;      //  список типов сырья
      FAllTime   : time;               //  полное время моделирования
      CurrentTime : time;              //  текущее время
      FOptimKoef  : double;            //  значение критерия оптимизации

      function GetCommBunkers : TListBunker;
      function GetGivenBunkers : TListBunker;
      function GetLines : TListAssembleLine;
      function GetMaterials : TListMaterial;
   public
      FShowProgress : boolean;
      point_count : integer;

      MaterialID : integer;
      LineID : integer;
      ReconfList : TReconfList;
      NextReconf : integer;

      procedure Clear;

      //  сохраняет параметры модели в файл
      procedure SaveToFile(filename : string);

      //  сохраняет параметры модели в память
      procedure SaveToMem;

      //  загружает параметры модели из файла
      procedure LoadFromFile(filename : string);

      //  загружает параметры модели из памяти
      procedure LoadFromMem;

      //  загружает информацию их другой модели
      procedure LoadFromModel(AModel : TModel);

      // подготовка к поиску решения
      procedure Prepare;

      // осуществляет поиск решения
      procedure Solve(p : TProgressBar);

      procedure Optimize(f:TForm);

      // Оценочная функция: вычисляет критерий оптимизации
      function Calc_OptimKoef : double;

      function IsMaterialUsed(MNumber : integer) : boolean;
      function IsLineUsed(MNumber : integer) : boolean;

      property CommBunkers : TListBunker read GetCommBunkers;
      property GivenBunkers : TListBunker read GetGivenBunkers;
      property Lines : TListAssembleLine read GetLines;
      property Materials : TListMaterial read GetMaterials;
      property AllTime : time read FAllTime write FAllTime;
      property OptimKoef : double read FOptimKoef;

      constructor Create;
      destructor Destroy;override;
end;


//  бункер
TBunker = class(TListObject)
   private
      FCapacity : massa;   //  емкость бункера
      FCurAmount : massa;  //  текущая загрузка
      Model : TModel;      //  указатель на хранящую его модель
      FLine : integer;     //  Линия обработки, с которой он связан
      function GetClosed: boolean;
   public
      procedure Save(var Mem : TMemoryStream);override;
      procedure Load(var Mem : TMemoryStream);override;

      procedure SetLine (value : integer);
      procedure SetCurAmount(value : massa);
      function GetLamda: massa;

      property Capacity : massa read FCapacity write FCapacity;
      property CurAmount : massa read FCurAmount write SetCurAmount;
      property Line : integer read FLine write SetLine;
      property Lamda : massa read GetLamda;
      property Closed : boolean read GetClosed;

      constructor Create (ObjList : TObjectList); override;
end;


//  точки на графике загруженности
TXY = record
    T : Time;
    Queue : Massa;
    Refusal : Massa;
end;

//  типы сырья
TMaterial = class(TListObject)
   private
      FNumber : integer;   //  внутренний номер
      LastTime : time;     //  последнее время обновления информации о содержимом
      FLamda : massa;      //  интенсивность входного потока (кг.сек)
      FQueue : massa;      //  длина очереди в тех же единицах, что и емкость
      FLimit : massa;      //  предел очереди
      FAllRefusal : massa; //  масса всего отказа
      FDone       : massa; //  отработано сырья
      FKoef       : double; // коэффициент полезности сырья

      PredQueue : massa; // для графика
      PredRefusal : massa; // для графика
      cur_i       : integer; // номер очередной точки на графике
      function GetModel: TModel;
   public
      //  массив точек для графика загруженности БОХ
      XY : array [0..MAX_POINTS] of TXY;
      //  параметры нормального распределения для скорости обработки
      //  единицы сырья
      sigma : massa; // среднеквадратичное отклонение
      mx    : massa; // матожидание

      procedure Save(var Mem : TMemoryStream);override;
      procedure Load(var Mem : TMemoryStream);override;
      procedure Prepare;override;
      procedure SetLamda(value : massa);

      procedure Refresh;    //  обновляет информацию о содержимом

      property Number : integer read FNumber;
      property Lamda : massa read FLamda write SetLamda;
      property Queue : massa read FQueue write FQueue;
      property Limit : massa read FLimit write FLimit;
      property AllRefusal : massa read FAllRefusal;
      property Model : TModel read GetModel;
      property Done : massa read FDone;
      property Koef : double read FKoef write FKoef;

      function GetAssembleTime(capacity : massa) : time;
      constructor Create(ObjList : TObjectList);override;
end;

TIntArray = array[0..MAX_MATERIALS] of integer;

//  линия обработки
TAssembleLine = class(TListObject)
   private
      FNumber : integer;   //  внутренний номер
      working : boolean;  //  занята ли работой

      closed : boolean;   // закрыта на перенастройку
      fromm, tom : integer;  // исходный и конечный типы сырья


      //  суммарное время работы за прошедшее время
      //  от начала моделирования
      FWorkTime : time;
      FPartCapacity : massa;  //  масса партии
      FMinPart      : massa;  //  минимальная партия загрузки
      FEndTime : time;        //  время окончания текущей работы
      FStartTime : time;      //  время начала выполнения текущей работы
      Model : TModel;
      FCurMaterialType : integer;
   public
      FReconfigure : TReconfigure;  //  матрица времен перенастройки

      procedure Save(var Mem : TMemoryStream);override;
      procedure Load(var Mem : TMemoryStream);override;
      procedure Prepare;override;

      procedure DoWork(for_time : time);
      procedure Refresh;

      function GetRestTime : time;
      procedure SetCurMaterialType(value : integer);

      property Number : integer read FNumber;
      property PartCapacity : massa read FPartCapacity write FPartCapacity;
      property MinPart : massa read FMinPart write FMinPart;
      property WorkTime : time read FWorkTime;
      property RestTime : time read GetRestTime;
      property CurMaterialType : integer read FCurMaterialType write SetCurMaterialType;

      constructor Create(ObjList : TObjectList);override;
      destructor Destroy;override;
end;


TListBunker = class(TObjectList)
public
    procedure Load(var Mem : TMemoryStream);override;
end;

TListMaterial = class(TObjectList)
 public
   procedure Load(var Mem : TMemoryStream);override;

   //  удаляет объект с индексом index
   procedure Delete(index : integer);override;

   //  вставляет объект после объекта с индексом after
   //  after = -1 вставить перед первым
   procedure Insert(after : integer; value : TListObject);override;
   function FindByName(AName : string) : TMaterial;
   function FindByNumber(ANumber: integer): integer;
   procedure SortByName(AName : string);
   procedure SortByNumber;
   procedure RefreshAll;
end;

TListAssembleLine = class(TObjectList)
  public
    //  вставляет объект после объекта с индексом after
    //  after = -1 вставить перед первым
    procedure Insert(after : integer; value : TListObject);override;
    procedure Load(var Mem : TMemoryStream);override;
    procedure RefreshAll;
    //  Возвращает индекс элемента в списке
    function FindByNumber(ANumber: integer): integer;
  private
    procedure MaterialAdded(material : integer);
    procedure MaterialDeleted(material : integer);
end;


TTimes = array of array of time;
TNumbers = array of integer;

TReconfigure = class
   private
      numbers : TNumbers;  //  содержит номера типов сырья, на которые указывают
                           //  строки массива times
      times : TTimes;
      procedure Clear;
   public
      constructor Create;
      destructor Destroy;override;

      procedure Load(var mem : TMemoryStream);
      procedure Save(var mem : TMemoryStream);

      procedure SetReconfTime(Material_from, Material_to : integer; value : time);
      function  GetReconfTime(Material_from, Material_to : integer) : time;
end;


RItem = class(TListObject)
  public
      rLine : integer;
      rTime : time;
      rFrom, rTo : integer;

      procedure Load(var mem : TMemoryStream);override;
      procedure Save(var mem : TMemoryStream);override;
      procedure Prepare;override;

      constructor Create(ObjList : TObjectList);override;
end;


TReconfList = class(TObjectList)
   public
      procedure SortAll;
      procedure Load(var mem : TMemoryStream);override;
end;



function ShortTime2Works(t : time) : string;
function Time2Works(t : time) : string;
function ShortTime2Str(t : time) : string;
function Time2Str(t : time) : string;
function Massa2Str(m : massa) : string;
function Time2StrLong(t : time) : string;
function Massa2StrLong(m : massa) : string;
function FindFirstInIntArray(a : integer; numbers : TIntArray) : integer;

implementation

Uses UOpt;

var
  MaterialName : string;
  MaterialNumber : integer;
  LineNumber : integer;
  Mem : TMemoryStream;

{ TModel }

function TModel.Calc_OptimKoef: double;
var
        i : integer;
begin
   result := 0;
   with Materials do
     for i := Low(list) to high(list) do
     begin
//        ShowMessage(format('i = %d, koef = %f, done = %f', [i, (List[i] as TMaterial).Koef, (List[i] as TMaterial).Done]));
        result := result + (List[i] as TMaterial).FKoef * (List[i] as TMaterial).FDone;
     end;
end;

procedure TModel.Clear;
begin
   FAllTime := 0;
   CurrentTime := 0;
   MaterialID := 0;
   LineId := 0;
   FCommBunkers.Clear;
   FGivenbunkers.Clear;
   FLines.Clear;
   FMaterials.Clear;
   ReconfList.Clear;
end;

constructor TModel.Create;
begin
   inherited;
   FAllTime := 0;
   CurrentTime := 0;
   MaterialID := 0;
   LineId := 0;
   NextReconf := 0;
   FOptimKoef := 0;
   FShowProgress := false;
   point_count := 7;

   FCommBunkers := TListBunker.Create(self);
   FGivenBunkers := TListBunker.Create(self);
   FMaterials := TListMaterial.Create(self);
   FLines := TListAssembleLine.Create(self);
   ReconfList := TReconfList.Create(self);
end;

destructor TModel.Destroy;
begin
   FCommBunkers.Free;
   FGivenBunkers.Free;
   FLines.Free;
   FMaterials.Free;
   ReconfList.Free;
   inherited;
end;

function TModel.GetCommBunkers: TListBunker;
begin
  result := FCommBunkers;
end;

function TModel.GetGivenBunkers: TListBunker;
begin
  result := FGivenBunkers;
end;

function TModel.GetLines: TListAssembleLine;
begin
  result := FLines;
end;

function TModel.GetMaterials: TListMaterial;
begin
   result := FMaterials;
end;

function TModel.IsLineUsed(MNumber: integer): boolean;
//  определяет, ссылается ли кто-нибудь на линию с номером MNumber
var
  i : integer;
begin
   result := true;

   with CommBunkers do
   for i := Low(List) to high(List) do
      if (list[i] as TBunker).Line = MNumber then exit;

   with GivenBunkers do
   for i := Low(List) to high(List) do
      if (list[i] as TBunker).Line = MNumber then exit;

   result := false;
end;

function TModel.IsMaterialUsed(MNumber: integer): boolean;
//  определяет, ссылается ли кто-нибудь на тип сырья с номером MNumber
var
  i : integer;
begin
   result := true;

   with Lines do
   for i := Low(List) to high(List) do
      if (list[i] as TAssembleLine).FCurMaterialType = MNumber then exit;

   result := false;
end;

procedure TModel.LoadFromFile(filename: string);
begin
  Mem.Clear;
  Mem.LoadFromFile (filename);
  LoadFromMem;
end;

procedure TModel.LoadFromMem;
begin
  Clear;    //  очищаем модель
  with Mem do
  begin
    Position := 0;
    Read(FAllTime, sizeof(FAllTime));
    Read(CurrentTime, sizeof(CurrentTime));
    CommBunkers.Load(Mem);
    GivenBunkers.Load(Mem);
    Materials.Load(Mem);
    Lines.Load(Mem);
    Read(MaterialID, sizeof(MaterialID));
    Read(LineID, sizeof(LineId));
    ReconfList.Load(Mem);
    Read(FShowProgress, sizeof(FShowProgress));
    Read(point_count, sizeof(point_count));
  end;
  Prepare;
end;

procedure TModel.LoadFromModel(AModel: TModel);
begin
   AModel.SaveToMem;
   self.LoadFromMem;
end;

//-------------------------------------------------------------------------
procedure TModel.Optimize(f : TForm);
type
    TGrafItem = record
        t : real;       //  время
        l : integer;    //  линия
        m : integer;    //  тип сырья, на который перенастроили (если е)
        e : boolean;    //  false, если начало и true, если  конец перенастройки
    end;
    TGrafik = array of TGrafItem;
    TCombArray = array of TGrafik;

    TLineInfo = record
        material : integer; //текущий тип сырья, 0 - идет перенастройка
    end;
    TLines = array of TLineInfo;

    TMaterialInfo = record
        number : integer;
        income_speed : real;
        assemble_speed : real;
        bunker_amount : real;
        max_bunker_amount : real;
        koef : real;
        done : real;
    end;
    TMaterials = array of TMaterialInfo;


    MaskItem = record
        l : integer;
        m : integer;
    end;
    // маска перенастроек
    TReconfMask = array of MaskItem;
var
    CombArray : TCombArray;
    BestGrafik : TGrafik;
    best_mark : real;
    ReconfMask : TReconfMask;
    step : real;
    ll : TLines;
    i : integer;
    count : integer;
    all_count : integer;
    begin_time : TDateTime;
    pred_time : TDateTime;
    cur_time : TDateTime;

    Obj : RItem;

    // Создаем маску перенастроек
    procedure GenerateReconfMask;
    var
        l : integer;
        m : integer;
        Line : TAssembleLine;
        Mater : TMaterial;
    begin
        // Перебираем линии обработки
        for l := Low(Lines.List) to High(Lines.List) do
        begin
             Line := (Lines.List[l] as TAssembleLine);
             // Добавляем текущий тип сырья !!!!!!!
             ///...............

             // Перебираем типы сырья, если на него можно настроить линию обработки,
             // то добавляем его в маску перенастроек
             for m := low(Materials.List) to High(Materials.List) do
             begin
                 Mater := Materials.List[m] as Tmaterial;
                 if (Line.FReconfigure.GetReconfTime(Line.CurMaterialType,  mater.number) + 1) > eps then
                 //  добавляем в маску перенастроек
                 begin
                     SetLength(ReconfMask, Length(ReconfMask) + 1);
                     ReconfMask[High(ReconfMask)].l := l;
                     ReconfMask[High(ReconfMask)].m := m;
                 end;
             end;
        end;
    end;

    function CombinationMark(index : integer) : real;
    var
       i, m : integer;
       v, p : real;
       lines : TLines;
       Materials : TMaterials;

       procedure AssembleItem;   // Обработка событий между двумя точками графика
       var
          m, l : integer;
       begin
          // Изменяем состояние линии
        if (i > Low(CombArray[index])) then
          if (CombArray[index][i - 1].e) then
             Lines[CombArray[index][i - 1].l].material  := Materials[CombArray[index][i - 1].m].number
          else
             Lines[CombArray[index][i - 1].l].material  := 0;

          // Для каждого типа сырья
          for m := Low(Materials) to High(Materials) do
          begin
              // Вычисляем суммарную производительность линий, на него настренных
              p := 0;
              for l := Low(Lines) to High(Lines) do
                if Lines[l].material = Materials[m].number then
                   p := p + Materials[m].assemble_speed;

              // Если скорость обработки меньше скорости поступления
              if p <= Materials[m].income_speed then
              begin
                   Materials[m].done := Materials[m].done + p * v;
                   Materials[m].bunker_amount := min(Materials[m].max_bunker_amount,
                         Materials[m].bunker_amount + v * (Materials[m].income_speed - p));
              end   else
              begin
                   Materials[m].done := Materials[m].done + min(p * v,  Materials[m].bunker_amount + v * Materials[m].income_speed);
                   Materials[m].bunker_amount :=  Max(0, Materials[m].bunker_amount + v * Materials[m].income_speed - min(p * v,  Materials[m].bunker_amount + v * Materials[m].income_speed));
              end;
          end; //  for m := Low(Materials) to High(Materials) do
       end; //  procedure AssembleItem;

    begin
       //  Загружаем начальную информацию
       SetLength(Lines, FLines.GetCount);
       SetLength(Materials, FMaterials.GetCount);

       for i := Low(Lines) to High(Lines) do
       begin
          Lines[i].material := (FLines.List[i] as TAssembleLine).FCurMaterialType
       end;

       for i := Low(Materials) to High(Materials) do
       begin
          Materials[i].number := (FMaterials.List[i] as TMaterial).FNumber;
          Materials[i].income_speed  := (FMaterials.List[i] as TMaterial).FLamda;
          Materials[i].assemble_speed   := (FMaterials.List[i] as TMaterial).mx;
          Materials[i].bunker_amount   := (FMaterials.List[i] as TMaterial).FQueue;
          Materials[i].max_bunker_amount   := (FMaterials.List[i] as TMaterial).FLimit;
          Materials[i].koef   := (FMaterials.List[i] as TMaterial).FKoef;
          Materials[i].done    := 0;
       end;


       //  Обходим все точки графика
       for i := Low(CombArray[index]) to High(CombArray[index]) do
       begin
          //  Вычисляем время между пред и тек точками
          if i = Low(CombArray[index]) then
             v := CombArray[index][i].t
          else
             v := CombArray[index][i].t - CombArray[index][i - 1].t;

          AssembleItem;
       end; // for i := Low(CombArray[index]) to High(CombArray[index]) do

       // От последней перенастройки до конца времени обработки
       i := High(CombArray[index]) + 1;
       if (Length(CombArray[index]) = 0) then
          v := AllTime
       else
          v := AllTime -  CombArray[index][i - 1].t;

       AssembleItem;

       // Вычисляем оценку графика
       result := 0;
       for m := Low(Materials) to High(Materials) do
          result := result + Materials[m].koef * Materials[m].Done;

    end; // function CombinationMark(index : integer) : real;


        // Создаем точки начала перенастройки
        // Создаем точки конца перенастройки
        // Сортируем точки по времени
    procedure GenerateCombinations(cur_point : integer);
    var
       i : integer;
       cur_mark : real;
       j : integer;
       temp_type : integer;
    begin
        if cur_point > point_count then
        begin
            cur_mark := CombinationMark(0);
    //        cur_mark := 0;
            if cur_mark > best_mark then
            begin
                // Запоминаем наилучший график
                // Запоминаем наилучшую оценку
                SetLength(BestGrafik, Length(CombArray[0]));
                for j := Low(BestGrafik) to High(BestGrafik) do
                begin
                   BestGrafik[j].t  := CombArray[0, j].t;
                   BestGrafik[j].l  := CombArray[0, j].l;
                   BestGrafik[j].m  := CombArray[0, j].m;
                   BestGrafik[j].e  := CombArray[0, j].e;
                end;
                best_mark := cur_mark;
            end;


if FShowProgress then begin
           inc(count);
           cur_time := sysutils.Time;
           if ((cur_time - pred_time) > 1/24/3600) then begin
              pred_time := cur_time;

            (f as TFOpt).count := count;
            (f as TFOpt).best := Round(best_mark / 1000);

            (f as TFOpt).LTime.Caption := TimeToStr(sysutils.Time - begin_time);

            (f as TFOpt).p_opt.position := round((count / all_count) * 100);
            f.Update;
          end;
end;

            if Length(CombArray[0]) > 0 then
              SetLength(CombArray[0], Length(CombArray[0]) - 2);
            exit;
        end;

        for i := Low(ReconfMask) to High(ReconfMask) do
        begin
//            temp_type := (Lines.List[ReconfMask[i].l] as TAssembleLine).CurMaterialType;
            temp_type := ll[ReconfMask[i].l].material;
            if temp_type <> (Materials.List[ReconfMask[i].m] as TMaterial).Number then
            begin
              SetLength(CombArray[0], Length(CombArray[0]) + 1);
              CombArray[0, High(CombArray[0])].t := step * (cur_point - 1);
              CombArray[0, High(CombArray[0])].l := ReconfMask[i].l;
              CombArray[0, High(CombArray[0])].m := ReconfMask[i].m;
              CombArray[0, High(CombArray[0])].e := false;

              SetLength(CombArray[0], Length(CombArray[0]) + 1);
              CombArray[0, High(CombArray[0])].t := step * (cur_point - 1) +
                 (Lines.List[ReconfMask[i].l] as TAssembleLine).FReconfigure.GetReconfTime(temp_type, (Materials.List[ReconfMask[i].m] as TMaterial).Number);
              ll[ReconfMask[i].l].material  := (Materials.List[ReconfMask[i].m] as TMaterial).Number;
              CombArray[0, High(CombArray[0])].l := ReconfMask[i].l;
              CombArray[0, High(CombArray[0])].m := ReconfMask[i].m;
              CombArray[0, High(CombArray[0])].e := true;
            end;
            GenerateCombinations(cur_point + 1);
            ll[ReconfMask[i].l].material  := temp_type;
        end;

        if Length(CombArray[0]) > 0 then
           SetLength(CombArray[0], Length(CombArray[0]) - 1);
    end;

begin
        // Создаем маску перенастроек
        GenerateReconfMask;

        step := AllTime / point_count;
        SetLength(CombArray, 1);
        best_mark := 0;
        SetLength(ll, FLines.Count);
        for i := Low(Ll) to High(Ll) do
        begin
           Ll[i].material := (FLines.List[i] as TAssembleLine).FCurMaterialType;
        end;

        // Генерируем комбинации и сразу их оцениваем
        count := 0;
        all_count := Round(IntPower(Length(ReconfMask), point_count));
        (f as TFOpt).lAll.Caption := IntToStr(all_count);
        begin_time := sysutils.time;
        GenerateCombinations(1);
        f.update;

        for i := Low(Ll) to High(Ll) do
        begin
           Ll[i].material := (FLines.List[i] as TAssembleLine).FCurMaterialType;
        end;

        //  Запоминаем в модели найденный лучший график перенастройки
        ReconfList.Clear;
        i := Low(BestGrafik);
        while i < High(BestGrafik) do
        begin
            obj := RItem.Create(ReconfList);
            ReconfList.Append(obj);
            obj.rLine := (Lines.List[BestGrafik[i].l] as TAssembleLine).number;
            obj.rFrom := LL[BestGrafik[i].l].material;
            obj.rTo := (Materials.List[BestGrafik[i].m] as TMaterial).Number;
            ll[BestGrafik[i].l].material := obj.rTo;
            obj.rTime := BestGrafik[i].t;
            i := i + 2;
        end;
        ReconfList.SortAll;
        MessageDlg(format('Оптимизация завершена. Оценка графика %d.', [Round(best_mark / 1000)]), mtInformation, [mbOk], 0);
end;

procedure TModel.Prepare;
begin
    CurrentTime := 0;
    NextReconf := 0;
    Lines.Prepare;
    Materials.Prepare;
end;

procedure TModel.SaveToFile(filename: string);
begin
  SaveToMem;
  Mem.SaveToFile (filename);
end;

procedure TModel.SaveToMem;
begin
  Prepare;
  with Mem do
  begin
    Mem.Clear;
    Write(FAllTime, sizeof(FAllTime));
    Write(CurrentTime, sizeof(CurrentTime));
    CommBunkers.Save(Mem);
    GivenBunkers.Save(Mem);
    Materials.Save(Mem);
    Lines.Save (Mem);    
    Write(MaterialID, sizeof(MaterialID));
    Write(LineID, sizeof(LineId));
    ReconfList.Save(Mem);
    Write(FShowProgress, sizeof(FShowProgress));
    Write(point_count, sizeof(point_count));    
  end;
end;


procedure TModel.Solve(p : TProgressBar);
var
   i : integer;
   Line : TAssembleLine;
   Bunker : TBunker;
   Material : TMaterial;
   NearestTime : time;
   Amount : massa;
   working_exists : boolean;
   procedure processBunkers(bunkers : TListBunker);
   var
     b : integer;
   begin
      with Bunkers do
      for b := Low(List) to High(List) do
      begin
        Bunker := (List[b] as TBunker);
        if (Bunker.Line = Line.Number) then
        begin
           if (Bunker.CurAmount < Line.MinPart) then
           begin
             with line do
             if (Closed) then
             begin              // Перенастройка линии 
                DoWork(FReconfigure.GetReconfTime(fromm, tom));
                // связываем линию с новым сырьем
                CurMaterialType := tom;
                // пока линию перенастраивают, бункер можно заполнять новым сырьем
                Closed := false;
                (Model.ReconfList.FList[NextReconf - 1] as RItem).RTime := 2 * AllTime;
                continue;
             end;
           end
           else
           begin
             Material := Materials.List[Materials.FindByNumber(Line.CurMaterialType)] as TMaterial;
             Amount := Min(Line.PartCapacity, Bunker.CurAmount);
             Bunker.CurAmount := Bunker.CurAmount - Amount;
             Material.FDone := Material.FDone + Amount;
             Line.DoWork(Material.GetAssembleTime(Amount));
           end;
        end;
      end;
   end;
begin
  Prepare;
  CurrentTime := 0;
  repeat
    NearestTime := AllTime;
    //  обновляем информацию о сырье и линиях обработки
    Materials.RefreshAll;
    Lines.RefreshAll;
    //  передвигаем ползунок
    if AllTime > eps then
    begin
      p.Position := round((CurrentTime/AllTime)*100);
      p.Update;
    end;
    //  перебираем все линии
    with Lines do
    for i := Low(List) to High(List) do
    begin
      Line := (List[i] as TAssembleline);
      //  перебираем сначала давальческие, а потом коммерческие бункеры
      //  с подходящим сырьем и загружаем им линию
      if Line.Working then continue;
      ProcessBunkers(GivenBunkers);
      if Line.Working then continue;
      ProcessBunkers(CommBunkers);
    end;

    //  расчитываем время следующего особого состояния
    working_exists := false;
    with Lines do
      for i := Low(List) to High(List) do
         if (List[i] as TAssembleLine).Working then
         begin
           working_exists := true;
           if NearestTime > (List[i] as TAssembleLine).FEndTime then
             NearestTime := (List[i] as TAssembleLine).FEndTime;
         end;

    //  обрабатываем текущее время
    if working_exists then   CurrentTime := NearestTime + eps
                      else   CurrentTime := CurrentTime + Step;

  until CurrentTime > AllTime;
  FOptimKoef := Calc_OptimKoef;
end;


{ TBunker }

constructor TBunker.Create;
var
  AModel : TModel;
begin
   inherited Create(ObjList);
   FCapacity := 0;
   FCurAmount := 0;
   Name := 'Бункер';
   FLine := -1;

   AModel := ObjList.Model;
   Model := nil;
   if (AModel <> nil) and (AModel is TModel) then
     Model := AModel;
end;


function TBunker.GetClosed: boolean;
var
  id : integer;
begin
   id := Model.Lines.FindByNumber(Line);
   result := (Model.Lines.List[id] as TAssembleLine).Closed;
end;

function TBunker.GetLamda: massa;
var
  L : TAssembleLine;
  i : integer;
begin
   result := 0;
   with Model do
   begin
      i := Lines.FindByNumber(Line);
      if  i = -1 then exit;
      L := Lines.List[i] as TAssembleLine;
      result := (Materials.List[Materials.FindByNumber(L.FCurMaterialType)] as TMaterial).Lamda;
   end;
end;

procedure TBunker.Load(var Mem: TMemoryStream);
begin
   with Mem do
   begin
      Read(Name, sizeof(Name));
      Read(FCapacity, sizeof(FCapacity));
      Read(FCurAmount, sizeof(FCurAmount));
      Read(FLine, sizeof(FLine));
   end;
end;

{
procedure TBunker.Refresh;
var
  add : massa; //  масса сырья, пришедшего с момента последнего обновления
  sub : massa;
begin
   //  Это надо делать по закону Пуассона
   add := (Model.CurrentTime - LastTime) * lamda;

   LastTime := Model.CurrentTime;
   FCurAmount := FCurAmount + add;
   if FCurAmount > FCapacity then
   //  помещам остаток в очередь
   begin
      FQueue := FQueue + FCurAmount - FCapacity;
      FCurAmount := FCapacity;

      //  учитываем предел очереди
      if FQueue > FLimit then
      begin
         FAllRefusal := FAllRefusal + FQueue - FLimit;
         FQueue := FLimit;
      end;
   end
   else
     //  забираем, сколько можем из очереди
     if abs(FQueue) > eps then
     begin
        sub := min(FQueue, FCapacity - FCurAmount);
        FQueue := FQueue - sub;
        FCurAmount := FCurAmount + sub;
     end;
end;
}

procedure TBunker.Save(var Mem: TMemoryStream);
begin
   with Mem do
   begin
      Write(Name, sizeof(Name));
      Write(FCapacity, sizeof(FCapacity));
      Write(FCurAmount, sizeof(FCurAmount));
      Write(FLine, sizeof(FLine));
   end;
end;


procedure TBunker.SetCurAmount(value: massa);
begin
   if (value >= 0) and (value <= FCapacity ) then
      FCurAmount := value;
end;

procedure TBunker.SetLine(value: integer);
begin
    if (value = -1) or (value >= 0) then
      FLine := value;
end;

{ TAssembleLine }

constructor TAssembleLine.Create;
var
  AModel : TModel;
begin
    inherited Create(ObjList);

    AModel := ObjList.Model;
    if (AModel <> nil) and (AModel is TModel) then
      Model := AModel
    else
      raise EBadModel.Create;

    Name := 'Линия обработки';
    working := false;
    closed := false;
    FStartTime := 0;
    FEndTime := 0;
    FPartCapacity := 0;
    FWorkTime := 0;
    FCurMaterialType := -1;

    inc(Model.LineID);
    FNumber := Model.LineID;

    FReconfigure := TReconfigure.Create;
end;

destructor TAssembleLine.Destroy;
begin
   FReconfigure.free;
   inherited;
end;

procedure TAssembleLine.DoWork(for_time : time);
begin
   if working then exit;
   working := true;
   FWorkTime := FWorkTime + for_time;
   FStartTime := Model.CurrentTime;
   FEndTime := FStartTime + for_time;
end;

function TAssembleLine.GetRestTime: time;
begin
   result := Model.FAllTime - WorkTime;
end;

procedure TAssembleLine.Load(var Mem: TMemoryStream);
begin
  with mem do
  begin
     Read(Name, sizeof(Name));
     Read(working, sizeof(Working));
     Read(FWorkTime, sizeof(FWorkTime));
     Read(FPartCapacity, sizeof(FPartCapacity));
     Read(FEndTime, sizeof(FEndTime));
     Read(FStartTime, sizeof(FStartTime));
     Read(FCurMaterialType, sizeof(FCurMaterialType));
     FReconfigure.Load(mem);
     Read(FMinPart, sizeof(FMinPart));
     Read(FNumber, sizeof(FNumber));
  end;
end;

procedure TAssembleLine.Prepare;
begin
   working := false;
   FWorkTime := 0;
   FEndTime := 0;
   FStartTime := 0;
   closed := false;
   fromm := -1;
   tom := -1;
end;

procedure TAssembleLine.Refresh;
var
   Item : RItem;
begin
   if (not closed) and (Model.NextReconf < Model.ReconfList.Count) then
   begin
     Item := Model.ReconfList.FList[Model.NextReconf] as RItem;
     if (Model.CurrentTime > Item.rTime) and (Item.rLine = Number) then
     begin
        closed := true;
        fromm := Item.rFrom;
        tom := Item.rTo;
        inc(Model.NextReconf);
     end;
   end;

   if Model.CurrentTime > FEndTime then
   begin
      working := false;
      FStartTime := 0;
      FEndTime := 0;
   end;
end;

procedure TAssembleLine.Save(var Mem: TMemoryStream);
begin
  with mem do
  begin
     Write(Name, sizeof(Name));
     Write(working, sizeof(Working));
     Write(FWorkTime, sizeof(FWorkTime));
     Write(FPartCapacity, sizeof(FPartCapacity));
     Write(FEndTime, sizeof(FEndTime));
     Write(FStartTime, sizeof(FStartTime));
     Write(FCurMaterialType, sizeof(FCurMaterialType));
     FReconfigure.Save(mem);
     Write(FMinPart, sizeof(FMinPart));
     Write(FNumber, sizeof(FNumber));
  end;
end;

procedure TAssembleLine.SetCurMaterialType(value: integer);
begin
   if Model.Materials.FindByNumber(value) = -1 then exit;
   FCurMaterialType := value;
end;

{ TList }

procedure TObjectList.Append(value: TListObject);
begin
    Insert(high(FList), value);
end;

procedure TObjectList.Clear;
var
  i : integer;
begin
   for i := Low(FList) to High(FList) do  FList[i].Free;
   SetLength(FList, 0);
end;

constructor TObjectList.Create(AModel : TModel);
begin
   inherited Create;
   Model := nil;
   if (AModel <> nil) and (AModel is TModel) then
     Model := AModel;
end;

procedure TObjectList.Delete(index: integer);
var
  i : integer;
begin
   for i := index to  high(FList) - 1 do  FList[i] := FList[i + 1];
   SetLength(FList, high(FList));
end;


destructor TObjectList.Destroy;
begin
   Clear;
   inherited;
end;

function TObjectList.FindObject(equal: TequalFunction): integer;
var
  i : integer;
begin
   result := -1;
   for i := 0 to high(FList) do
      if equal(FList[i]) then
      begin
         result := i;
         exit;
      end;
end;


function TObjectList.GetCount: integer;
begin
   result := high(FList) + 1;
end;

procedure TObjectList.Insert(after: integer; value: TListObject);
var
  i : integer;
begin
   SetLength(FList, Length(FList) + 1);
   for i := high(FList) downto after + 2 do
     FList[i] := FList[i - 1];

   FList[after + 1] := value;
   FList[after + 1].FObjectList := self;
end;


procedure Sort(var a : TObjectArray; first, last : integer; compare : TCompareFunction);
//  сортировка массива методом построения дерева
var
  low, high : integer;
  temp, separator : TListObject;
begin
  low := first;
  high := last;
  if high < low then exit;
  separator := a[(first + last) div 2];
  repeat
     while (Compare(a[low], separator) < 0) do inc(low);
     while (Compare(a[high], separator) > 0) do dec(high);
     if (low <= high) then
     begin
        temp := a[low];
        a[low] := a[high];
        a[high] := temp;
        inc(low);
        dec(high);
     end;
  until not (low <= high);
  if (first < high) then Sort(a, first, high, compare);
  if (low < last) then Sort(a, low, last, compare);
end;


procedure TObjectList.Prepare;
var
  i : integer;
begin
   for i := Low(List) to High(List) do
     List[i].Prepare;
end;

procedure TObjectList.Save(var Mem: TMemoryStream);
var
  i , count : integer;
begin
   count := Length(Flist);
   Mem.Write(count, sizeof(count));
   for i := Low(FList) to High(FList) do
     FList[i].Save(Mem);
end;

procedure TObjectList.Sort(compare: TCompareFunction);
begin
   tc.Sort(FList, low(Flist), high(FList), compare);
end;


{ TMaterial }

constructor TMaterial.Create;
var
  i : integer;
begin
   inherited Create(ObjList);
   Name := 'Тип сырья';
   inc(Model.MaterialID);
   FNumber := Model.MaterialID;
   sigma := 0;
   mx := 0;
   FLimit := 0;
   FQueue := 0;
   FAllRefusal := 0;
   LastTime := 0;
   FDone := 0;
   FKoef := 0;
   for i := 0 to MAX_POINTS do
   begin
     XY[i].T := 0;
     XY[i].Queue := 0;
     XY[i].Refusal := 0;
   end;
   PredQueue := 0;
end;

function TMaterial.GetAssembleTime(capacity: massa): time;
//  Вычисляем время обработки сырья, используя закон нормального распределения
var
  i : integer;
  sum : massa;
begin
   sum := 0;
   for i := 1 to NORMAL_MAX_NUMBERS do
      sum := sum + 2 * random - 1;

   result := (sqrt(3/NORMAL_MAX_NUMBERS) * sigma * sum + mx);
   if result > eps then
     result := capacity / result
   else
     result := MAX_TIME;
end;


function TMaterial.GetModel: TModel;
begin
    result := ObjectList.Model;
end;

procedure TMaterial.Load(var Mem: TMemoryStream);
begin
  with Mem do
  begin
     Read(Name, sizeof(Name));
     Read(FNumber, sizeof(FNumber));
     Read(sigma, sizeof(sigma));
     Read(mx, sizeof(mx));
     Read(FLamda, sizeof(FLamda));
     Read(FQueue, sizeof(FQueue));
     Read(FLimit, sizeof(FLimit));
     Read(FAllRefusal, sizeof(FAllRefusal));
     Read(LastTime, sizeof(LastTime));
     Read(FKoef, sizeof(FKoef));     
  end;
end;

procedure TMaterial.Prepare;
var
  i : integer;
begin
   FAllRefusal := 0;
   LastTime := 0;
   FDone := 0;
   for i := 0 to MAX_POINTS do
   begin
     XY[i].T := (Model.FAllTime - 3600) / MAX_POINTS * i;
   end;
   cur_i := 1;
   PredQueue := FQueue;
   PredRefusal := FAllRefusal;
   XY[0].Queue := FQueue;
end;


procedure TMaterial.Refresh;
var
  add : massa; //  масса сырья, пришедшего с момента последнего обновления
  sub : massa;
  i : integer;
begin
   add := (Model.CurrentTime - LastTime) * lamda;

   //  Ищем бункеры, связанные с данным сырьем
   with Model.GivenBunkers do
      for i := Low(List) to High(List) do
        // если линия бункера связана с нужным типом сырья и бункер не закрыт на перенастройку,
        // заполняем его сырьем
        if ((Model.Lines.List[Model.Lines.FindByNumber((List[i] as TBunker).Line)] as TAssembleLine).FCurMaterialType = Number) and
           (not (List[i] as TBunker).closed)  then
           with List[i] as TBunker do
           begin
              sub := Min(FCapacity - FCurAmount, add);
              add := add - sub;
              FCurAmount := FCurAmount + sub;
              //  забираем, сколько можем из БОХ
              if (FCurAmount < FCapacity) and (abs(FQueue) > eps) then
              begin
                sub := min(FQueue, FCapacity - FCurAmount);
                FQueue := FQueue - sub;
                FCurAmount := FCurAmount + sub;
              end;
           end;

   //  помещам остаток в БОХ
   if add > eps then
   begin
      FQueue := FQueue + add;
      //  учитываем емкость БОХ
      if FQueue > FLimit then
      begin
         FAllRefusal := FAllRefusal + FQueue - FLimit;
         FQueue := FLimit;
      end;
   end;

   //  точки для графика
   with Model do
     if (LastTime <= XY[cur_i].T) and (CurrentTime >= XY[cur_i].T) then
     begin
        XY[cur_i].Queue := (PredQueue + FQueue) / 2;
        XY[cur_i].Refusal := (FAllRefusal + PredRefusal) / 2;
        inc(cur_i);
     end;

   PredQueue := FQueue;
   PredRefusal := FAllRefusal;
   LastTime := Model.CurrentTime;
end;

procedure TMaterial.Save(var Mem: TMemoryStream);
begin
  with Mem do
  begin
     Write(Name, sizeof(Name));
     Write(FNumber, sizeof(FNumber));
     Write(sigma, sizeof(sigma));
     write(mx, sizeof(mx));
     Write(FLamda, sizeof(FLamda));
     Write(FQueue, sizeof(FQueue));
     Write(FLimit, sizeof(FLimit));
     Write(FAllRefusal, sizeof(FAllRefusal));
     Write(LastTime, sizeof(LastTime));
     Write(FKoef, sizeof(FKoef));
  end;
end;

procedure TMaterial.SetLamda(value: massa);
begin
    if (value >= 0) then FLamda := value;
end;

{ TListMaterial }

function EqualByMaterialName(AObject : TObject) : boolean;
begin
    result := false;
    if not (AObject is TMaterial) then exit;
    if (AnsiCompareStr((AObject as TMaterial).Name, MaterialName) = 0) then
      result := true;
end;

function EqualByMaterialNumber(AObject : TObject) : boolean;
begin
    result := false;
    if not (AObject is TMaterial) then exit;
    if (AObject as TMaterial).Number = MaterialNumber then
      result := true;
end;

function CompareMaterialName(AObject1, AObject2 : TObject) : integer;
begin
   result := 0;
   if not((AObject1 is TMaterial) and (AObject2 is TMaterial)) then exit;
   result :=
     AnsiCompareStr((AObject1 as TMaterial).Name, (AObject2 as TMaterial).Name);
end;

function CompareMaterialNumber(AObject1, AObject2 : TObject) : integer;
begin
   result := 0;
   if not((AObject1 is TMaterial) and (AObject2 is TMaterial)) then exit;
   if (AObject1 as TMaterial).Number < (AObject2 as TMaterial).Number then
     result := -1
   else if (AObject1 as TMaterial).Number > (AObject2 as TMaterial).Number then
     result := 1;
end;

procedure TListMaterial.Delete(index: integer);
begin
  Model.FLines.MaterialDeleted((List[index] as TMaterial).number);
  inherited;
end;

function TListMaterial.FindByName(AName: string): TMaterial;
var
  index : integer;
begin
   MaterialName := AName;
   index := FindObject(EqualByMaterialName);
   if (index <> -1) and (list[index] is TMaterial) then
     result := List[index] as TMaterial
   else
     result := nil;
end;

function TListMaterial.FindByNumber(ANumber: integer): integer;
begin
   MaterialNumber := ANumber;
   result := FindObject(EqualByMaterialNumber);
end;


procedure TListMaterial.Insert(after: integer; value: TListObject);
begin
  if not (value is TMaterial) then exit;
  Model.FLines.MaterialAdded((value as TMaterial).Number);
  inherited;
end;

procedure TListMaterial.Load(var Mem: TMemoryStream);
var
   i : integer;
   count : integer;
   Obj : TMaterial;
begin
   count := Length(Flist);
   Mem.Read(count, sizeof(count));
   for i := 0 to count - 1 do
   begin
      Obj := TMaterial.Create(self);
      Append(Obj);
      Obj.Load(Mem);
   end;
end;


procedure TListMaterial.RefreshAll;
var
  i : integer;
begin
   for i := Low(List) to High(List) do
     (List[i] as TMaterial).Refresh;
end;

procedure TListMaterial.SortByName(AName: string);
begin
   Sort(CompareMaterialName);
end;

procedure TListMaterial.SortByNumber;
begin
  Sort(CompareMaterialNumber);
end;

{ TListObject }

constructor TListObject.Create;
begin
   inherited Create;
   FObjectList := ObjList;
end;

{ TListBunker }

procedure TListBunker.Load(var Mem: TMemoryStream);
var
   i : integer;
   count : integer;
   Obj : TBunker;
begin
   count := Length(Flist);
   Mem.Read(count, sizeof(count));
   for i := 0 to count - 1 do
   begin
      Obj := TBunker.Create(self);
      Append(Obj);
      Obj.Load(Mem);
   end;
end;


{ TListAssembleLine }

function EqualByLineNumber(AObject : TObject) : boolean;
begin
    result := false;
    if not (AObject is TAssembleLine) then exit;
    if (AObject as TAssembleLine).Number = LineNumber then
      result := true;
end;


function TListAssembleLine.FindByNumber(ANumber: integer): integer;
begin
   LineNumber := ANumber;
   result := FindObject(EqualByLineNumber);
end;

procedure TListAssembleLine.Insert(after: integer; value: TListObject);
var
   i, m, material, line : integer;
begin
  inherited;
{
  with Model.Materials do
  for i := Low(List) to High(list) do
    MaterialAdded((List[i] as TMaterial).number);
}
    for m := Low(Model.Materials.List) to High(Model.Materials.list) do
    begin
     material := (Model.Materials.List[m] as TMaterial).number;
     with (FList[high(FList)] as TAssembleline).FReconfigure do
     begin
         //  добавляем указатель
         SetLength(numbers, length(numbers) + 1);
         numbers[high(numbers)] := material;

         //  добавляем к каждой строке массива перенастроек по элементу
         for i := Low(times) to high(times) do
         begin
            SetLength(times[i], Length(times[i]) + 1);
            times[i][High(times[i])] := -1;
         end;

         //  добавляем строку в конец
         SetLength(times, Length(times) + 1);
         SetLength(times[high(times)], length(times));
         for i := Low(times[high(times)]) to high(times[high(times)]) do
           times[high(times)][i] := -1;

         times[high(times)][high(times[high(times)])] := 0;
     end;
   end;
end;

procedure TListAssembleLine.Load(var Mem: TMemoryStream);
var
   i : integer;
   count : integer;
   Obj : TAssembleLine;
begin
   count := Length(Flist);
   Mem.Read(count, sizeof(count));
   for i := 0 to count - 1 do
   begin
      Obj := TAssembleLine.Create(self);
      Append(Obj);
      Obj.Load(Mem);
   end;
end;

procedure TListAssembleLine.MaterialAdded(material: integer);
var
  i, Line : integer;
begin
   //  перебираем все линии обработки
   for Line := Low(FList) to High(FList) do
     with (FList[Line] as TAssembleLine) do
     with FReconfigure do
     begin
         //  добавляем указатель
         SetLength(numbers, length(numbers) + 1);
         numbers[high(numbers)] := material;

         //  добавляем к каждой строке массива перенастроек по элементу
         for i := Low(times) to high(times) do
         begin
            SetLength(times[i], Length(times[i]) + 1);
            times[i][High(times[i])] := -1;
         end;

         //  добавляем строку в конец
         SetLength(times, Length(times) + 1);
         SetLength(times[high(times)], length(times));
         for i := Low(times[high(times)]) to high(times[high(times)]) do
           times[high(times)][i] := -1;

         times[high(times)][high(times[high(times)])] := 0;
     end;
end;

procedure TListAssembleLine.MaterialDeleted(material: integer);
var
  index, i, Line : integer;
begin
   //  перебираем все линии обработки
   for Line := Low(FList) to High(FList) do
     with (FList[Line] as TAssembleLine) do
     with FReconfigure do
     begin
        (*
          1. Ищем индекс строки массива, соответствующей удаляемому типу сырья.
          2. Освобождаем память, занятую этой строкой
          3. Помещаем на осободившееся место указатель на последнюю строку
          4. Освобождаем память, занятую последним элементом массива указателей на строки

          5. Переписываем последний элемент number на место удаленного типа сырья
          6. Освобождаем последний number
          7. В каждой строке times переписываем значение последнего элемента на место
             удаленного
          8. Освобождаем последние элементы строк
        *)
{ 1 }
         index := -1;
         for i := Low(numbers) to high(numbers) do
            if (numbers[i] = material) then
              index := i;
         ASSERT(index <> -1, 'тип сырья в массиве перенастроек не найден');
         if (index = -1) then exit;
{ 2, 3, 4 }
         times[index] := Copy(times[high(times)], 0, Length(times[high(times)]));
         SetLength(times[high(times)], 0);
         SetLength(times, Length(times) - 1);
{ 5, 6 }
         numbers[index] := numbers[high(numbers)];
         SetLength(numbers, Length(numbers) - 1);
{ 7, 8 }
         for i := Low(times) to high(times) do
         begin
            times[i][index] := times[i][high(times[i])];
            SetLength(times[i], Length(times[i]) - 1);
         end;
     end;
end;

procedure TListAssembleLine.RefreshAll;
var
   i : integer;
begin
   for i := Low(List) to High(List) do
     (List[i] as TAssembleLine).Refresh;
end;


{ TReconfigure }

procedure TReconfigure.Clear;
var
  i, j : integer;
begin
  for i := Low(times) to high(times) do
    for j := Low(times[i]) to high(times[i]) do
      times[i][j] := 0;
end;

constructor TReconfigure.Create;
begin
  inherited;
  SetLength(times, 0);
  SetLength(numbers, 0);
end;

destructor TReconfigure.Destroy;
var
  i: integer;
begin
  for i := Low(times) to High(times) do   SetLength(times[i], 0);
  SetLength(times, 0);
  SetLength(numbers, 0);
  inherited;
end;

function TReconfigure.GetReconfTime(Material_from,
  Material_to: integer): time;
var
  _from, _to  : integer;
  i : integer;
begin
   _from := -1;
   _to := -1;
   for i := Low(numbers) to High(numbers) do
   begin
     if numbers[i] = Material_from then _from := i;
     if numbers[i] = Material_to   then _to   := i;
   end;
   ASSERT(_from <> -1);
   ASSERT(_to <> -1);
   result := times[_from][_to];
end;

procedure TReconfigure.Save(var mem: TMemoryStream);
var
  i, j : integer;
  rows, cols : integer;
begin
    rows := Length(times);
    cols := Length(times[0]);
    with mem do
    begin
       write(rows, sizeof(rows));
       write(cols, sizeof(cols));
       for i := Low(times) to high(times) do
       begin
         write(numbers[i], sizeof(numbers[i]));
         for j := Low(times[i]) to high(times[i]) do
           write(times[i][j], sizeof(times[i][j]));
       end;
    end;
end;

procedure TReconfigure.Load(var mem: TMemoryStream);
var
  i, j : integer;
  rows, cols : integer;
begin
    with mem do
    begin
       read(rows, sizeof(rows));
       read(cols, sizeof(cols));
       SetLength(times, rows);
       SetLength(numbers, rows);
       for i := Low(times) to High(times) do
         SetLength(times[i], cols);
       self.Clear;
       for i := Low(times) to high(times) do
       begin
         read(numbers[i], sizeof(numbers[i]));
         for j := Low(times[i]) to high(times[i]) do
           read(times[i][j], sizeof(times[i][j]));
       end;
    end;
end;

procedure TReconfigure.SetReconfTime(Material_from, Material_to: integer; value : time);
var
  _from, _to  : integer;
  i : integer;
begin
   _from := -1;
   _to := -1;
   for i := Low(numbers) to High(numbers) do
   begin
     if numbers[i] = Material_from then _from := i;
     if numbers[i] = Material_to   then _to   := i;
   end;
   ASSERT(_from <> -1);
   ASSERT(_to <> -1);
   times[_from][_to] := value;
end;

{ EBadModel }

constructor EBadModel.Create;
begin
   Message := MSG_BAD_MODEL;
end;


{ RItem }

constructor RItem.Create(ObjList: TObjectList);
begin
  inherited;
  rLine := -1;
  rTime := -1;
  rFrom := -1;
  rTo := -1;
end;

procedure RItem.Load(var mem: TMemoryStream);
begin
    with mem do
    begin
       Read(rLine, sizeof(rLine));
       Read(rTime, sizeof(RTime));
       Read(rFrom, sizeof(RFrom));
       Read(rTo, sizeof(rTo));
    end;
end;

procedure RItem.Prepare;
begin
  inherited;
end;

procedure RItem.Save(var mem: TMemoryStream);
begin
    with mem do
    begin
       Write(rLine, sizeof(rLine));
       Write(rTime, sizeof(RTime));
       Write(rFrom, sizeof(RFrom));
       Write(rTo, sizeof(rTo));
    end;
end;

{ TReconfList }

function CompareReconfTime(AObject1, AObject2 : TObject) : integer;
begin
   result := 0;
   if not((AObject1 is RItem) and (AObject2 is RItem)) then exit;
   if (AObject1 as RItem).rTime < (AObject2 as RItem).rTime then
     result := -1
   else if (AObject1 as RItem).rTime > (AObject2 as rItem).rTime then
     result := 1;
end;


procedure TReconfList.Load(var mem: TMemoryStream);
var
   i : integer;
   count : integer;
   Obj : RItem;
begin
   Mem.Read(count, sizeof(count));
   for i := 0 to count - 1 do
   begin
      Obj := RItem.Create(self);
      Append(Obj);
      Obj.Load(Mem);
   end;
   SortAll;
end;



{ routings }

function Time2StrLong(t : time) : string;
var
  hour,
  minut,
  sec   : integer;
begin
   hour := round(t) div 3600;
   minut := (round(t) mod 3600) div 60;
   sec := (round(t) mod 60);
   result := format('%d часов %d минут %d секунд', [hour, minut, sec]);
end;

function ShortTime2Works(t : time) : string;
begin
   result := format('  %d  ', [round(t / (3600 * 8))]);
end;

function Time2Works(t : time) : string;
begin
   result := format('количество смен: %d', [round(t / (3600 * 8))]);
end;

function Time2Str(t : time) : string;
var
  hour,
  minut,
  sec   : integer;
begin
   hour := round(t) div 3600;
   minut := (round(t) mod 3600) div 60;
   sec := (round(t) mod 60);
   result := format('%d ч. %d мин. %d сек.', [hour, minut, sec]);
end;

function ShortTime2Str(t : time) : string;
var
  hour,
  minut : integer;
begin
   hour := round(t) div 3600;
   minut := (round(t) mod 3600) div 60;
   result := format('%d ч. %d мин', [hour, minut]);
end;

function Massa2StrLong(m : massa) : string;
var
  kg, tn, gr : integer;
begin
   tn := round(m) div 1000;
   kg := (trunc(m) mod 1000);
   gr := round(frac(m) * 1000);
   if tn = 0 then
     result := format('%d кг %d гр', [kg, gr])
   else
     result := format('%d тон %d кг', [tn, kg]);
end;

function Massa2Str(m : massa) : string;
var
  kg, tn, gr : integer;
begin
   tn := round(m) div 1000;
   kg := (trunc(m) mod 1000);
   gr := round(frac(m)* 1000);
   if tn = 0 then
     result := format('%d кг %d гр', [kg, gr])
   else
     result := format('%d т %d кг', [tn, kg]);
end;

function FindFirstInIntArray(a : integer; numbers : TIntArray) : integer;
var
  i : integer;
begin
   result := -1;
   for i := Low(numbers) to high(numbers) do
    if numbers[i] = a then
    begin
       result := i;
       exit;
    end;
end;

procedure TReconfList.SortAll;
begin
    Sort(CompareReconfTime);
end;

{ ENotInteger }

constructor ENotFloat.Create;
begin
   Message := MSG_NOT_FLOAT;
end;

initialization

Randomize;
Mem := TMemoryStream.Create;

finalization

Mem.Free;

end.
