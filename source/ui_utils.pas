{ ui_utils.pas
  Description: Routines for manipulating the
               User Interface of the applicaation


  This file is part of SNESC Favorites.

  SNESC Favorites is free software: you can redistribute it and/or modify
  it under the terms of the GNU General Public License as published by
  the Free Software Foundation, either version 3 of the License, or
  (at your option) any later version.

  SNESC Favorites is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  GNU General Public License for more details.

  You should have received a copy of the GNU General Public License
  along with SNESC Favorites.  If not, see <http://www.gnu.org/licenses/>.

}

unit ui_utils;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Controls, LCLtype, LCLIntf, Graphics, Checklst;

procedure CheckListBoxDrawItem(Control: TWinControl; Index: Integer;
  ARect: TRect; State: TOwnerDrawState);


implementation

procedure CheckListBoxDrawItem(Control: TWinControl; Index: Integer;
  ARect: TRect; State: TOwnerDrawState);
Var clOld: TColor;
    w : Integer;
    OldBrushStyle: TBrushStyle;
    OldTextStyle: TTextStyle;
    NewTextStyle: TTextStyle;
    BRect: TRect;
    b,c: Boolean;
    OldStyle: TFontStyles;
    s: string;
const
   MARGIN = 2;
   IsChecked : array[Boolean] of Integer = (DFCS_BUTTONCHECK, DFCS_BUTTONCHECK or DFCS_CHECKED) ;
begin
   b := odSelected In State;
   c := odFocused In State;
   With TCheckListBox(Control) Do
   Begin
      clOld := Canvas.Font.Color;
      OldBrushStyle := Canvas.Brush.Style;
      OldTextStyle := Canvas.TextStyle;
      OldStyle := Canvas.Font.Style;
      s := Items[Index];
     if (s <> '') and (s[1] = '-') then
       begin
         Canvas.Brush.Style := bsSolid;
         Canvas.Brush.Color := clWhite;

         Canvas.Font.Style := [fsBold];
         Canvas.FillRect(ARect);
         Canvas.Pen.Style := psSolid;
         Canvas.Pen.Color := $F6D8AD;
         Canvas.Font.Color := $F6D8AD;
         Canvas.Line(
           ARect.Left + MARGIN,
           (ARect.Top + ARect.Bottom) div 2,
           ARect.Right - MARGIN,
           (ARect.Top + ARect.Bottom) div 2
         );
         Delete(s, 1, 1);
         if s <> '' then
           begin
             s := ' ' + s + ' ';
             w := Canvas.TextWidth(s);
             Canvas.TextOut(
               (ARect.Left + ARect.Right - w) div 2,
               (ARect.Top + ARect.Bottom - Canvas.TextHeight('Tg')) div 2,
               s
             );
           end;
         Canvas.Pen.Style := psClear;
         Canvas.Brush.Style := bsClear;
         Canvas.Pen.Color := clWhite;
         if (c) then Canvas.DrawFocusRect(ARect);
         Canvas.Font.Style:=[];
         Canvas.Font.Color := clOld;
         Canvas.Brush.Style := OldBrushStyle;
         Canvas.TextStyle := OldTextStyle;
         Canvas.Font.Style := OldStyle;
         exit;
       end;

      s := Items[Index];
      if (s <> '') and (s[1] = '-') then exit;
      Canvas.Brush.Color := Brush.Color;
      Canvas.FillRect(ARect);
      Canvas.Brush.Style := bsClear;
      BRect.Left := ARect.Left + 1;
      BRect.Top := ARect.Top + 1;
      BRect.Bottom := ARect.Bottom+ 2;
      BRect.Right := ARect.Left + (ARect.Bottom - ARect.Top) - 2;

      DrawFrameControl(Canvas.Handle, BRect, DFC_BUTTON, IsChecked[Checked[Index]]);

      If b Then
         Canvas.Font.Style := [fsBold];

      If Checked[Index] Then
      Begin
        Canvas.Font.Color := clBlue;
      end Else Canvas.Font.Color := Font.Color;
      NewTextStyle := OldTextStyle;
      NewTextStyle.Layout := tlCenter;
      Canvas.TextStyle := NewTextStyle;
      ARect.Left := BRect.Right;
      Canvas.TextRect(ARect, ARect.Left+2, ARect.Top, Items[Index]);

      Canvas.Font.Color := clOld;
      Canvas.Brush.Style := OldBrushStyle;
      Canvas.TextStyle := OldTextStyle;
      Canvas.Font.Style := OldStyle;
   end;
end;

end.
