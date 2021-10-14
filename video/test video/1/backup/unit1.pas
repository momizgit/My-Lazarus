unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls,
  PasLibVlcPlayerUnit;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    od: TOpenDialog;
    pvlc: TPasLibVlcPlayer;
    procedure Button1Click(Sender: TObject);
    procedure pvlcClick(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.Button1Click(Sender: TObject);
begin
     pvlc.Play(WideString(od.FileName));
end;

procedure TForm1.pvlcClick(Sender: TObject);
begin

end;

end.

