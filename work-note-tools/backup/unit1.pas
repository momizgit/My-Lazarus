unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, Menus, StdCtrls,
  Clipbrd, ExtCtrls,Strutils,Unit2,fileinfo, my_units,ShellApi, fileutil;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Btn3: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    Button7: TButton;
    PastBtn1: TButton;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Edit5: TEdit;
    Edit6: TEdit;
    Edit7: TEdit;
    Exit_Btn: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    FilterBox: TListBox;
    Label8: TLabel;
    MenuItem10: TMenuItem;
    MenuItem11: TMenuItem;
    MenuItem9: TMenuItem;
    PastBtn2: TButton;
    PastBtn3: TButton;
    PastBtn4: TButton;
    SelectedNote: TMemo;
    NoteCount: TLabel;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    AddRemoveMenu: TPopupMenu;
    BraketMenu: TPopupMenu;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    MenuItem5: TMenuItem;
    MenuItem6: TMenuItem;
    MenuItem7: TMenuItem;
    MenuItem8: TMenuItem;
    Notes: TListBox;
    procedure Btn3Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Edit4Change(Sender: TObject);
    procedure Edit4Click(Sender: TObject);
    procedure Edit4KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Edit4MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Edit6Change(Sender: TObject);
    procedure Exit_BtnClick(Sender: TObject);
    procedure FilterBoxClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure MenuItem10Click(Sender: TObject);
    procedure MenuItem11Click(Sender: TObject);
    procedure MenuItem1Click(Sender: TObject);
    procedure MenuItem2Click(Sender: TObject);
    procedure MenuItem3Click(Sender: TObject);
    procedure MenuItem4Click(Sender: TObject);
    procedure MenuItem5Click(Sender: TObject);
    procedure MenuItem6Click(Sender: TObject);
    procedure MenuItem7Click(Sender: TObject);
    procedure MenuItem8Click(Sender: TObject);
    procedure MenuItem9Click(Sender: TObject);
    procedure NotesClick(Sender: TObject);
    procedure NotesDblClick(Sender: TObject);
    procedure NotesMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure NotesMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure IsNoteFileOpen(IsNoteFile:Boolean=False;IsOpenFile:Boolean=False);
    procedure Copy2List(CopyBack2ListBox:boolean = False; ToAdd:boolean = False);
    procedure PastBtn1Click(Sender: TObject);
    procedure PastBtn2Click(Sender: TObject);
    procedure PastBtn3Click(Sender: TObject);
    procedure PastBtn4Click(Sender: TObject);
  private

  public

  end;

  procedure textPaste(textString:String);
var
  Form1: TForm1;
  cursorPos: integer;
  ListIndex:Integer;
  stringToPaste: String;
  ClickToSelect:boolean;
  Info: TVersionInfo;


const
  lineBreak = '<LBR>';
  braket1 = '<BR1>';
  braket2 = '<BR2>';
  braket3 = '<BR3>';
  braket4 = '<BR4>';
  NoteFile = 'Notes.wnt';
  TempFile = 'Temp.wnt';

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.Exit_BtnClick(Sender: TObject);
begin
  Close;
end;

procedure TForm1.FilterBoxClick(Sender: TObject);
var
  i:integer;
begin
     IsNoteFIleOpen(False,True);//Open Temp file
     If(Filterbox.GetSelectedText='All')then exit;
     For i:=Notes.Items.Count-1 downto 0 do begin
            if (Filterbox.GetSelectedText<>Leftstr(Notes.Items[i],10)) then Notes.Items.Delete(i);
     End;
end;

procedure TForm1.FormClose(Sender: TObject; var CloseAction: TCloseAction);
Var
  i:Integer;
begin
    IsNoteFIleOpen(False,True);//Open Temp file
    For i:=Notes.Items.Count-1 downto 0 do
      Begin
         if (LeftStr(Notes.Items[i],10)='0         ') then Notes.Items.Delete(i) ;
      end;
    IsNoteFileOpen(True,False);//Save to Note file
end;

procedure TForm1.Edit4Change(Sender: TObject);
begin
   if(Edit4.Text<>'') then Button1.Enabled:=true else Button1.Enabled:=false;
   cursorPos:=Edit4.SelStart;
end;

procedure TForm1.Edit4Click(Sender: TObject);
begin
     cursorPos:=Edit4.SelStart;
end;

procedure TForm1.Edit4KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState
  );
begin
   cursorPos:=Edit4.SelStart;
end;

procedure TForm1.Edit4MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
     if Button=mbRight then showmessage(inttostr(edit4.SelStart));
end;

procedure TForm1.Edit6Change(Sender: TObject);
var
  I: Integer;
begin
   if Edit6.Text<>'' then Btn3.Enabled:=True else Btn3.Enabled:=false;
   {if(Edit6.Text='') then Notes.ClearSelection;
   index:=Notes.Items.Count-1;
   while(index > 0) and (CompareText(Edit6.Text,Notes.Items[index])<0) do Dec(index);
   Notes.ItemIndex:=index;}
   Notes.MultiSelect:=True;
     for I := 0 to Notes.Items.Count - 1 do Notes.Selected[I] := False;

  for I := 0 to Notes.Items.Count - 1 do begin
     if Notes.Items.Strings[I].Contains(Edit6.Text) then Notes.Selected[I] := True;
     if Notes.Items.Strings[I].Contains(UpperCase(Edit6.Text)) then Notes.Selected[I] := True;
     if Notes.Items.Strings[I].Contains(LowerCase(Edit6.Text)) then Notes.Selected[I] := True;
     end;
    // else Notes.Items.Delete(I);
  If ClickToSelect=True then begin
     Notes.MultiSelect:=False;
     Notes.Selected[ListIndex];
     ClickToSelect:=False;
  end;

end;

procedure TForm1.Button1Click(Sender: TObject);
begin
   if(Length(Edit7.Text)<10) then Edit7.Text:=PadRight(Edit7.Text,10);
   IsNoteFIleOpen(False,True);//Open Temp file
   if(Edit4.Text<>'') then Notes.Items.Add(Edit7.Text+'-'+Edit4.Text);
   Copy2List();
   Notes.Sorted:=true;
   Edit4.Clear;
   Edit7.Clear;
   Edit7.SetFocus;
   Button1.Enabled:=false;
   IsNoteFileOpen();//Save to Temp file
end;

procedure TForm1.Btn3Click(Sender: TObject);
begin
  Edit6.Text:='';
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  Form2.Show;
  //RunAsAdmin(Form1.Handle, 'rundll32.exe shell32.dll,Control_RunDLL appwiz.cpl', '');
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  Edit4.Text:=Edit4.Text + lineBreak;
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
  Edit4.Text:=Edit4.Text + braket1;
end;

procedure TForm1.Button5Click(Sender: TObject);
begin
  Edit4.Text:=Edit4.Text + braket2;
end;

procedure TForm1.Button6Click(Sender: TObject);
begin
  Edit4.Text:=Edit4.Text + braket3;
end;

procedure TForm1.Button7Click(Sender: TObject);
begin
  Edit4.Text:=Edit4.Text + braket4;
end;

procedure TForm1.FormCreate(Sender: TObject);
var
  Version: string;
  i,index:integer;
begin
  if(FileExists('BUNotes.wnt')) then MenuItem11.Visible:=True else MenuItem11.Visible:=False;
  IsNoteFileOpen(True,True);//Open Note file
  IsNoteFileOpen();//Save to Temp file
  IsNoteFileOpen(False,True); //Open Temp file
  Info := TVersionInfo.Create;
  Info.Load(HINSTANCE);
  Version := Format('%d.%d.%d.%d', [Info.FixedInfo.FileVersion[0],Info.FixedInfo.FileVersion[1],Info.FixedInfo.FileVersion[2],Info.FixedInfo.FileVersion[3]]);
  Info.Free;
  self.Caption:='Work Notes tool v'+ Version;
   ClickToSelect:=False;
   //If(FileExists(noteFile)) then Notes.Items.LoadFromFile(noteFile);
   if(Notes.Count<=0) then exit;
   Copy2List(True);
end;

procedure TForm1.MenuItem10Click(Sender: TObject);
begin

end;

procedure TForm1.MenuItem11Click(Sender: TObject);
begin
  CopyFile('BUNotes.wnt',TempFile);
end;

procedure TForm1.MenuItem1Click(Sender: TObject);
begin
  If (Button1.Enabled) then Form1.Button1Click(Sender) else ShowMessage('Nothing to add');
end;

procedure TForm1.MenuItem2Click(Sender: TObject);
begin
     if(Notes.ItemIndex<>-1) then begin
        Notes.Items.Delete(Notes.ItemIndex);
        IsNoteFileOpen();//Save to temp file
     end else ShowMessage('Nothing selected');

end;

procedure TForm1.MenuItem3Click(Sender: TObject);
begin
  textPaste(braket1);
end;

procedure TForm1.MenuItem4Click(Sender: TObject);
begin
  textPaste(braket2);
end;

procedure TForm1.MenuItem5Click(Sender: TObject);
begin
  textPaste(braket3);
end;

procedure TForm1.MenuItem6Click(Sender: TObject);
begin
  textPaste(braket4);
end;

procedure TForm1.MenuItem7Click(Sender: TObject);
begin
   textPaste(lineBreak);
end;

procedure TForm1.MenuItem8Click(Sender: TObject);
begin
  //RunShellExecute('Notepad.exe',noteFile);
  //ShellExecute(0,'open','Notepad.exe',noteFile,1)
  ShellExecute(Handle, nil, PChar(TempFile),PChar(ExtractFilePath(Application.ExeName) + noteFile),nil,1)
end;

procedure TForm1.MenuItem9Click(Sender: TObject);
begin
  CopyFile(TempFile,'BUNotes.wnt');
end;


procedure TForm1.NotesClick(Sender: TObject);
var
  tempStr:string;
begin
  //SelectedIndex:=Notes.ItemIndex;
   tempStr:=Notes.GetSelectedText;
   //ListIndex:=Notes.ItemIndex;
   //Showmessage(inttostr(ListIndex));
   //showmessage(tempStr);
  if(pos(lineBreak,tempStr)>0) then
    tempStr:=stringreplace(tempStr,lineBreak,#13#10,[rfReplaceAll]);
  if(Edit1.Text<>'') and (pos(braket1,tempStr)>0) then
    tempStr:=stringreplace(tempStr,braket1,Edit1.Text,[rfReplaceAll]);
  if(Edit2.Text<>'') and (pos(braket2,tempStr)>0) then
    tempStr:=stringreplace(tempStr,braket2,Edit2.Text,[rfReplaceAll]);
  if(Edit3.Text<>'') and (pos(braket3,tempStr)>0) then
    tempStr:=stringreplace(tempStr,braket3,Edit3.Text,[rfReplaceAll]);
  if(Edit5.Text<>'') and (pos(braket4,tempStr)>0) then
    tempStr:=stringreplace(tempStr,braket4,Edit5.Text,[rfReplaceAll]);

  tempStr:=RightStr(tempStr,Length(tempStr)-11);
  SelectedNote.Text:=tempStr;
  Clipboard.AsText:=tempStr;

  Edit1.Clear;
  Edit2.Clear;
  Edit3.Clear;
  Edit5.Clear;

end;

procedure TForm1.NotesDblClick(Sender: TObject);
begin
   ShowMessage(SelectedNote.Text);
end;

procedure TForm1.NotesMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  If (Button=mbLeft) then begin
     ClickToSelect:=True;
     Edit6.Clear;
  end;
end;

procedure TForm1.NotesMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Notes.Selected[ListIndex];
end;

procedure TForm1.IsNoteFileOpen(IsNoteFile:Boolean=False;IsOpenFile:Boolean=False);
var
  SelectedFile:String;

Begin
  SelectedFile:=ifthen((IsNoteFile),NoteFile,TempFile);
     If(Not(IsOpenFile))Then Notes.Items.SaveToFile(SelectedFile)
     else if(FileExists(SelectedFile)) then Notes.Items.LoadFromFile(SelectedFile) else NoteCount.Caption:='File not found';
end;

procedure TForm1.Copy2List(CopyBack2ListBox:boolean = False; ToAdd:boolean = False);
Var
  i,index:integer;
begin
         Filterbox.Clear;
         Filterbox.Items.Add('All');

         For i:=0 to Notes.Count-1 do
            begin
                 Filterbox.Items.Add(LeftStr(Notes.Items[i],10));
            end;

         For i := Filterbox.Items.Count - 1 downto 0 do
             begin
                    index := Filterbox.Items.IndexOf(Filterbox.Items[i]);
                    if index < i then
                       Filterbox.Items.Delete(i);
             end;
   NoteCount.Caption:= 'Note Count: '+ IntToStr(Notes.Count);
end;

procedure TForm1.PastBtn1Click(Sender: TObject);
begin
  Edit1.Text:=Clipboard.AsText;
end;

procedure TForm1.PastBtn2Click(Sender: TObject);
begin
  Edit2.Text:=Clipboard.AsText;
end;

procedure TForm1.PastBtn3Click(Sender: TObject);
begin
  Edit3.Text:=Clipboard.AsText;
end;

procedure TForm1.PastBtn4Click(Sender: TObject);
begin
  Edit5.Text:=Clipboard.AsText;
end;

procedure textPaste(textString:String);
var
  tempStr1, tempStr2:String;
begin
  tempStr1 := LeftStr(Form1.Edit4.Text,cursorPos);
  //ShowMessage(inttostr(Length(Form1.Edit4.text)) + ' - ' + inttostr(cursorPos));
  if(Length(Form1.Edit4.Text) = cursorPos) then
    tempStr2 := ''
  else
    tempStr2 := RightStr(Form1.Edit4.Text,Length(Form1.Edit4.Text) - cursorPos);
  Form1.Edit4.Text := tempStr1 + textString + tempStr2;
  Form1.Edit4.SelStart:=Length(Form1.Edit4.text);
end;

end.

