unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Label1: TLabel;
    Label2: TLabel;
    SelDir1: TSelectDirectoryDialog;
    SelDir2: TSelectDirectoryDialog;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
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
  SelDir1.Execute;
  label1.Caption:=SelDir1.FileName;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
    SelDir2.Execute;
  label2.Caption:=SelDir2.FileName;
end;

procedure TForm1.Button5Click(Sender: TObject);
begin
  Close;
end;

end.

