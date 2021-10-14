unit frm1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, PasLibVlcPlayerUnit, Forms, Controls, Graphics,
  Dialogs, ExtCtrls, StdCtrls, Buttons, ComCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    btnOpen: TBitBtn;
    btnOpenURL: TBitBtn;
    btnPlay: TBitBtn;
    btnPause: TBitBtn;
    lblTime: TLabel;
    OpenDialog1: TOpenDialog;
    Panel1: TPanel;
    vlcPlayer: TPasLibVlcPlayer;
    trkPosition: TTrackBar;
    trkVolume: TTrackBar;
    procedure btnOpenClick(Sender: TObject);
    procedure btnOpenURLClick(Sender: TObject);
    procedure btnPauseClick(Sender: TObject);
    procedure btnPlayClick(Sender: TObject);
    procedure Label1Click(Sender: TObject);
    procedure Panel1Exit(Sender: TObject);
    procedure trkPositionChange(Sender: TObject);
    procedure trkPositionMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure trkPositionMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure trkVolumeChange(Sender: TObject);
    procedure vlcPlayerMediaPlayerLengthChanged(Sender: TObject; time: Int64);
    procedure vlcPlayerMediaPlayerTimeChanged(Sender: TObject; time: Int64);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  Form1: TForm1;
  videoFile:String;
  textFileptr: textFile;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.btnOpenClick(Sender: TObject);
var
  filePos:String;
begin
  if OpenDialog1.Execute then begin
    videoFile:= OpenDialog1.FileName;
 {   if not fileExists(videoFile + '.pos') then
      begin
        AssignFile(textFileptr,videoFile + '.pos');
         ReWrite(textFileptr);
      end
    else
        begin
          AssignFile(textFileptr,videoFile + '.pos');
          try
             reset(textFileptr);
             while not eof(textFileptr) do
             begin
                 readln(textFileptr,filePos);
             end;
          finally
                 writeln(filePos);
          end;
        end;    }
    vlcPlayer.Play(WideString(videoFile));
    Caption := videoFile + ' --- ' + ExtractFilePath(videoFile) + ' --- ' +  ExtractFileName(videoFile);
  end;
end;

procedure TForm1.btnOpenURLClick(Sender: TObject);
begin
  videoFile := InputBox('Media URL', 'Please enter media URL/MRL', '');
  if videoFile <> '' then begin
    vlcPlayer.Play(WideString(videoFile));
    Caption := videoFile;
  end;
end;

procedure TForm1.btnPauseClick(Sender: TObject);
begin
  vlcPlayer.Pause();
end;

procedure TForm1.btnPlayClick(Sender: TObject);
begin
  vlcPlayer.Resume();
end;

procedure TForm1.Label1Click(Sender: TObject);
begin

end;

procedure TForm1.Panel1Exit(Sender: TObject);
begin
  try
     Rewrite(textFileptr);
     Writeln(textFileptr, IntToStr(trkPosition.Position));
  finally
         CloseFile(textFileptr);
  end;
end;

procedure TForm1.trkPositionChange(Sender: TObject);
begin

end;

procedure TForm1.trkPositionMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  trkPosition.Tag := 1;
end;

procedure TForm1.trkPositionMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  vlcPlayer.SetVideoPosInMs(trkPosition.Position);
  trkPosition.Tag := 0;
end;

procedure TForm1.trkVolumeChange(Sender: TObject);
begin
  vlcPlayer.SetAudioVolume(trkVolume.Position);
end;

procedure TForm1.vlcPlayerMediaPlayerLengthChanged(Sender: TObject; time: Int64
  );
begin
  trkPosition.Max := vlcPlayer.GetVideoLenInMs();
end;

procedure TForm1.vlcPlayerMediaPlayerTimeChanged(Sender: TObject; time: Int64);
begin
  if trkPosition.Tag = 0 then // not dragging with mouse
    trkPosition.Position := vlcPlayer.GetVideoPosInMs();
  lblTime.Caption:=vlcPlayer.GetVideoPosStr('hh:mm:ss');
end;

end.

