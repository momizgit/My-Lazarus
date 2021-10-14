program TuteSlide;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, TuteSlideUnit, TuteSlideDisplayUnit
  { you can add units after this };

{$R *.res}

begin
  RequireDerivedFormResource:=True;
  Application.Scaled:=True;
  Application.Initialize;
  Application.CreateForm(TTuteSlideDisplay, TuteSlideDisplay);
  Application.CreateForm(TTuteSlideDisplayBoard, TuteSlideDisplayBoard);
  Application.Run;
end.

