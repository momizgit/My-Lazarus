unit TuteSlideUnit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, ComCtrls,
  EditBtn, FileCtrl, StdCtrls, Menus, TuteSlideDisplayUnit;

type

  { TTuteSlideDisplay }

  TTuteSlideDisplay = class(TForm)
    CheckBox1: TCheckBox;
    FileBox: TFileListBox;
    ListBox1: TListBox;
    SelDir: TSelectDirectoryDialog;
    procedure CheckBox1Change(Sender: TObject);
    procedure FileBoxChange(Sender: TObject);
    procedure FileBoxClick(Sender: TObject);
    procedure FileBoxDblClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ListBox1Click(Sender: TObject);
    procedure MenuItem1Click(Sender: TObject);
  private

  public

  end;

var
  TuteSlideDisplay: TTuteSlideDisplay;

implementation

{$R *.lfm}

{ TTuteSlideDisplay }

procedure TTuteSlideDisplay.FormCreate(Sender: TObject);
begin
  if FileExists('Note.csv') then Listbox1.Items.LoadFromFile('Note.csv');
end;

procedure TTuteSlideDisplay.FileBoxDblClick(Sender: TObject);
begin
  SelDir.Execute;
  //Filebox.Mask:='*.bmp; *.jpg; *.gif; *.png; *.jpeg; *.tif';
  Filebox.Mask:='*.jpg; *.png; *.bmp';
  FileBox.Directory := SelDir.FileName;
  FileBox.UpdateFileList;
end;

procedure TTuteSlideDisplay.FileBoxClick(Sender: TObject);
begin
  if(FileBox.FileName<>'') then
  begin
    TuteSlideDisplayBoard.Image1.Visible:=True;
    TuteSlideDisplayBoard.Label1.Visible:=False;
    TuteSlideDisplayBoard.Image1.Picture.LoadFromFile(FileBox.FileName);
    TuteSlideDisplayBoard.Height:=TuteSlideDisplayBoard.Image1.Height;
    TuteSlideDisplayBoard.Width:=TuteSlideDisplayBoard.Image1.Width;
  end;
end;

procedure TTuteSlideDisplay.FileBoxChange(Sender: TObject);
begin

end;

procedure TTuteSlideDisplay.CheckBox1Change(Sender: TObject);
begin
  if (checkbox1.Checked) then TuteSlideDisplayBoard.FormStyle:=fsSystemStayOnTop
  else TuteSlideDisplayBoard.FormStyle:=fsNormal;
end;

procedure TTuteSlideDisplay.FormShow(Sender: TObject);
begin
  TuteSlideDisplayBoard.Show;
end;

procedure TTuteSlideDisplay.ListBox1Click(Sender: TObject);
begin
  if ListBox1.GetSelectedText<>'' then
  Begin
    TuteSlideDisplayBoard.Image1.Visible:=False;
    TuteSlideDisplayBoard.Label1.Visible:=True;
    TuteSlideDisplayBoard.Label1.Caption:=ListBox1.GetSelectedText;
    TuteSlideDisplayBoard.Height:=TuteSlideDisplayBoard.Label1.Height;
    TuteSlideDisplayBoard.Width:=TuteSlideDisplayBoard.Label1.Width;
  end;
end;

procedure TTuteSlideDisplay.MenuItem1Click(Sender: TObject);
begin

end;

end.

