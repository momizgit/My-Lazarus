(*
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
 *
 * Any non-GPL usage of this software or parts of this software is strictly
 * forbidden.
 *
 * The "appropriate copyright message" mentioned in section 2c of the GPLv2
 * must read: "Code from FAAD2 is copyright (c) Nero AG, www.nero.com"
 *
 *)

{$I ..\..\source\compiler.inc}

program DemoUseLog;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  Windows, SysUtils, SyncObjs,
  PasLibVlcUnit in '..\..\source\PasLibVlcUnit.pas';

const
  DEMO_FILE = '..\..\_testFiles\Maximize.mp4';

var
  p_li : libvlc_instance_t_ptr;
  p_md : libvlc_media_t_ptr;
  p_mi : libvlc_media_player_t_ptr;

  f: TextFile;

procedure libvlc_log_cb(
    data      : Pointer;
    level     : libvlc_log_level_t;
    const ctx : libvlc_log_t_ptr;
    const fmt : PAnsiChar;
    args      : TVaPtrListPtr); cdecl;
var
  fmt_chr : AnsiChar;
  fmt_idx : Integer;

  out_str : AnsiString;
  tmp_str : AnsiString;
  fmt_str : AnsiString;
  fmt_spc : AnsiString;
  tmp_chr : PAnsiChar;
begin
  out_str := '';
  fmt_str := fmt;

  if (level = LIBVLC_LOG_DEBUG) then exit;

  WriteLn(f, 'fmt: ', fmt); Flush(f);

  while (fmt_str <> '') do
  begin
    fmt_idx := Pos('%', fmt_str);
    if (fmt_idx < 1) then break;

    out_str := out_str + Copy(fmt_str, 1, fmt_idx-1);
    Delete(fmt_str, 1, fmt_idx);

    fmt_spc := '';
    while (fmt_str <> '') and (fmt_str[1] in ['0'..'9', '.', 'z', 'l', ' ', '+', '-', '#']) do
    begin
      fmt_spc := fmt_spc + fmt_str[1];
      Delete(fmt_str, 1, 1);
    end;
    if (fmt_str = '') then break;

    fmt_chr := fmt_str[1];
    Delete(fmt_str, 1, 1);

    case fmt_chr of
      '%' : begin
        out_str := out_str + '%';
        continue;
      end;
      's' : begin
        tmp_chr := PAnsiChar(args^);
        tmp_str := '';

        if (fmt_spc = '4.4') then
        begin
          if (tmp_chr^ <> #00) then
          begin
            tmp_str := tmp_str + tmp_chr^; Inc(tmp_chr);
          end;
          if (tmp_chr^ <> #00) then
          begin
            tmp_str := tmp_str + tmp_chr^; Inc(tmp_chr);
          end;
          if (tmp_chr^ <> #00) then
          begin
            tmp_str := tmp_str + tmp_chr^; Inc(tmp_chr);
          end;
          if (tmp_chr^ <> #00) then
          begin
            tmp_str := tmp_str + tmp_chr^; // Inc(tmp_chr);
          end;
          while (Length(tmp_str) < 4) do
          begin
            tmp_str := ' ' + tmp_str;
          end;
        end
        else
        begin
          while (tmp_chr <> NIL) and (tmp_chr^ <> #00) do
          begin
            tmp_str := tmp_str + tmp_chr^;
            Inc(tmp_chr);
          end;
        end;
        out_str := out_str + tmp_str;
      end;
      'd' : begin
        if (fmt_spc = 'll') then
        begin
          tmp_str := IntToStr(Integer(args^));
        end
        else
        if (fmt_spc = 'l') then
        begin
          tmp_str := IntToStr(Integer(args^));
        end
        else
        if (fmt_spc = 'z') then
        begin
          tmp_str := IntToStr(SmallInt(args^));
        end
        else
        begin
          tmp_str := IntToStr(Integer(args^));
        end;
        out_str := out_str + tmp_str;
      end;
      'i' : begin
        tmp_str := IntToStr(Integer(args^));
        out_str := out_str + tmp_str;
      end;
      'u' : begin
        if (fmt_spc = 'll') then
        begin
          tmp_str := IntToStr(Cardinal(args^));
        end
        else
        if (fmt_spc = 'z') then
        begin
          tmp_str := IntToStr(Word(args^));
        end
        else
        begin
          tmp_str := IntToStr(Cardinal(args^));
        end;
        out_str := out_str + tmp_str;
      end;
      'x', 'X' : begin
        tmp_str := IntToHex(Cardinal(args^), 8);
        out_str := out_str + tmp_str;
      end;
      'f' : begin
        tmp_str := Format('%' + fmt_spc + fmt_chr, [Single(args^)]);
        out_str := out_str + tmp_str;
      end;
    end;

    Inc(args);
  end;
  out_str := out_str + fmt_str;

  WriteLn(f, 'out: ', out_str); Flush(f);
  WriteLn(out_str);

end;

begin
  {$IFDEF DELPHI2007_UP}
  ReportMemoryLeaksOnShutdown := TRUE;
  {$ENDIF}

  AssignFile(f, 'dump.txt');
  ReWrite(f);

  try

    SetConsoleOutputCP(65001);

    libvlc_dynamic_dll_init();

    if (libvlc_dynamic_dll_error <> '') then
    begin
      raise Exception.Create(libvlc_dynamic_dll_error);
    end;

    with TArgcArgs.Create([
      libvlc_dynamic_dll_path,
      '--intf=dummy',
      '--ignore-config',
      '--quiet',
      '--no-video-title-show'
    ]) do
    begin
      p_li := libvlc_new(ARGC, ARGS);
      Free;
    end;

    libvlc_log_set(p_li, libvlc_log_cb, NIL);

    p_md := libvlc_media_new_path(p_li, PAnsiChar(UTF8Encode(DEMO_FILE)));
    libvlc_media_parse(p_md);

    p_mi := libvlc_media_player_new_from_media(p_md);

    libvlc_media_player_play(p_mi);

    while (libvlc_media_player_get_state(p_mi) <> libvlc_Ended) do
    begin
      Sleep(50);
    end;

    libvlc_media_release(p_md);
    libvlc_media_player_release(p_mi);
    libvlc_release(p_li);

  except
    on E:Exception do
      Writeln(E.Classname, ': ', E.Message);
  end;

  Flush(f);
  Close(f);

  ReadLn;
end.
