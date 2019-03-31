unit UGlobalTypes;

interface

type
  TECellType = (ctEmpty, ctAinable, ctWall, ctBox, ctBoxPlace, ctHome);

  TCMap = class
  private
    mapH, mapW: integer;
    map: array of array of set of TECellType;
  public
    procedure LoadMapFromFile(FileName: string);
  end;

implementation

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
  SetLength(self.map, Self.mapH + 1);
  Readln(f, Self.mapW);
  for I := 1 to Self.mapH do
    SetLength(Self.map[I], Self.mapW + 1);
  for I := 1 to Self.mapH do
    for j := 1 to Self.mapW do
      self.map[I, j] := [ctEmpty];
  while not Eof(f) do
  begin
    read(f, I);
    read(f, j);
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
end;

end.
