unit Unit2;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls,windows, my_units,strutils,math, RunElevatedSupport;

type

  { TForm2 }

  TForm2 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Edit1: TEdit;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    ListBox1: TListBox;
    ListBox2: TListBox;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    procedure Button1Click(Sender: TObject);
    procedure Edit1Enter(Sender: TObject);
    procedure Edit1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormCreate(Sender: TObject);
    procedure RadioButton1Change(Sender: TObject);
    procedure RadioButton2Change(Sender: TObject);
    procedure remoteSelected;
  private


  public

  end;


var
  Form2: TForm2;



implementation

{$R *.lfm}

{ TForm2 }


procedure TForm2.FormCreate(Sender: TObject);
begin

end;

procedure TForm2.RadioButton1Change(Sender: TObject);
begin
  remoteSelected;
end;

procedure TForm2.RadioButton2Change(Sender: TObject);
begin
  remoteSelected;
end;

procedure TForm2.Button1Click(Sender: TObject);
begin
  //executeprocess('notepad.exe',['document.txt']);
  //RunAsAdmin(Form2.Handle,'cmd.exe','/c ipconfig & pause');
  //RunACommans('cmd.exe /c ipconfig & pause','');  // This one works as well
  //RunACommans('cmd.exe',['123','456']);
  showmessage(ifthen(1>2,'1111111111111','22222222222'));
end;

procedure TForm2.Edit1Enter(Sender: TObject);
begin
  if (Edit1.Text = 'Computer name or IP Address') then Edit1.Text:='';
end;

procedure TForm2.Edit1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if (Edit1.Text = 'Computer name or IP Address') then Edit1.Text:='';
end;

procedure Tform2.remoteSelected;
begin
     if(Radiobutton1.Checked)then begin
       Button2.Enabled:=true;
       Edit1.Enabled:=true;
       Button1.Enabled:=true;
       Label2.Caption:='XXXXXXXXXXXXX'
     end
     else begin
       Button2.Enabled:=false;
       Edit1.Enabled:=false;
       Button1.Enabled:=false;
       Label2.Caption:=GettheHostName;
     end;
end;

end.

