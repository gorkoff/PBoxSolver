unit UformMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TForm1 = class(TForm)
    btnLoadMap: TButton;
    procedure btnLoadMapClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}
uses
  UGlobalTypes;

procedure TForm1.btnLoadMapClick(Sender: TObject);
var
  map: UGlobalTypes.TCMap;
begin
  map := TCMap.Create;
  map.LoadMapFromFile('map.txt');
end;

end.
