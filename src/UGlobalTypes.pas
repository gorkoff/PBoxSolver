unit UGlobalTypes;

interface

uses
  Vcl.Graphics;

type
  TECellType = (ctWall, ctEmpty, ctAinable, ctBox, ctBoxPlace, ctHome);

  TCMap = class
  private
    mapH, mapW: integer;
    map: array of array of set of TECellType;
  public
    procedure LoadMapFromFile(FileName: string);
    procedure CalculateMap;
    function DrawMap: TBitmap;
  end;

implementation

uses
  UColorImages;

procedure TCMap.LoadMapFromFile(FileName: string);
var
  f: TextFile;
  I: Integer;
  j: Integer;
  t: AnsiChar;
begin
  AssignFile(f, FileName);
  Reset(f);
  Read(f, Self.mapH);
  SetLength(self.map, Self.mapH + 2);
  Readln(f, Self.mapW);
  for I := 0 to Self.mapH + 1 do
    SetLength(Self.map[I], Self.mapW + 2);
  for I := 0 to Self.mapH + 1 do
    for j := 0 to Self.mapW + 1 do
      if (I < 1) or (I > mapH) or (j < 1) or (j > mapW) then
        self.map[I, j] := [ctWall]
      else
        self.map[I, j] := [ctEmpty];
  while not Eof(f) do
  begin
    read(f, I);
    read(f, j);
    read(f, t);
    Readln(f, t);
    case t of
      'H':
        map[I, j] := map[I, j] + [ctHome];
      'I':
        map[I, j] := map[I, j] + [ctAinable];
      'W':
        map[I, j] := map[I, j] + [ctWall];
      'B':
        map[I, j] := map[I, j] + [ctBox];
      'P':
        map[I, j] := map[I, j] + [ctBoxPlace];
    end;
  end;
  CloseFile(f);
  Self.CalculateMap;
end;

procedure TCMap.CalculateMap;
var
  fl: Boolean;
  i: Integer;
  j: Integer;
begin
  fl := true;
  while fl do
  begin
    fl := False;
    for i := 1 to mapH do
      for j := 1 to mapW do
        if ctAinable in map[i, j] then
        begin
          if (not (ctWall in map[i - 1, j])) and (not (ctBox in map[i - 1, j])) and (not (ctAinable in map[i - 1, j])) then
          begin
            map[i - 1, j] := map[i - 1, j] + [ctAinable];
            fl := True;
          end;
          if (not (ctWall in map[i + 1, j])) and (not (ctBox in map[i + 1, j])) and (not (ctAinable in map[i + 1, j])) then
          begin
            map[i + 1, j] := map[i + 1, j] + [ctAinable];
            fl := True;
          end;
          if (not (ctWall in map[i, j - 1])) and (not (ctBox in map[i, j - 1])) and (not (ctAinable in map[i, j - 1])) then
          begin
            map[i, j - 1] := map[i, j - 1] + [ctAinable];
            fl := True;
          end;
          if (not (ctWall in map[i, j + 1])) and (not (ctBox in map[i, j + 1])) and (not (ctAinable in map[i, j + 1])) then
          begin
            map[i, j + 1] := map[i, j + 1] + [ctAinable];
            fl := True;
          end;
        end;
  end;

end;

function TCMap.DrawMap: TBitmap;
var
  CI: UcolorImages.TCColorImage;
  i: Integer;
  j: Integer;
begin
  CI := TCColorImage.Create;
  CI.Height := mapH;
  CI.Width := mapW;
  for i := 1 to mapH do
    for j := 1 to mapW do
      if ctWall in map[i, j] then
        CI.Pixels[i - 1, j - 1].FullColor := clBlack
      else if ctBox in map[i, j] then
        CI.Pixels[i - 1, j - 1].FullColor := clWebBrown
      else if ctBoxPlace in map[i, j] then
        CI.Pixels[i - 1, j - 1].FullColor := clWebSandyBrown
      else if ctAinable in map[i, j] then
        CI.Pixels[i - 1, j - 1].FullColor := clGreen
      else if ctHome in map[i, j] then
        CI.Pixels[i - 1, j - 1].FullColor := clRed
      else
        CI.Pixels[i - 1, j - 1].FullColor := clWhite;
  DrawMap := CI.SaveToBitMap;
end;

end.

