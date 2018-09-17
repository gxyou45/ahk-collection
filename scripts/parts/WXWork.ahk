; Set of keyboard shortcuts for WXwork common use cases
;
; ===== List of key bindings =====
;
; [ Shared between different window types if applicable ]
; Alt+x: Focus on search box
; Alt+j: Down
; Alt+k: Up
;
; [ Main Window ]
; Alt+s: Send the hint sticker
; Ctrl+1~3: Switch to Chats, Contacts, and Favorites respectively
; Ctrl+,: Open settings
; Alt+1~8: Switch to the 1~8-th conversation from the top of the list
; Alt+c: Expand/Collapse all contacts in search results
; Alt+g: Expand/Collapse all groups in search results
;
; [ Image Preview ]
; j: Right
; k: Left
; s: Save as
; r: Rotate image
;
; [ WebView ]
; Alt+x: Open the hamburger menu
;

SetDefaultMouseSpeed, 0

#include Utils.ahk

;
; Util functions
;

clickFirstToggle()
{
  PixelGetColor, testColor, 150, 60
  if testColor <> 0xDEDEDE
  {
    return
  }
  clickAndBack(280, 15)
}

clickWXworkChatItem(index)
{
  chatListPosX := 50
  chatListPosY := 63
  chatItemW := 250
  chatItemH := 61
  chatItemClickX := chatListPosX + chatItemW / 2
  chatItemClickY := chatListPosY + chatItemH / 2
  clickAndBack(chatItemClickX, chatItemClickY + index * chatItemH)
}

sendSticker()
{
  clickAndBack(A_CaretX + 2, A_CaretY - 2)
  WinActivate, ahk_class WeChatMainWndForPC
}

#IfWinActive ahk_class WeChatMainWndForPC
!s::sendSticker()
!x::clickAndBack(175, 40)
!n::clickAndBack(290, 40)
!c::clickFirstToggle()
!g::
PixelGetColor, testColor, 150, 380
if testColor <> 0xDEDEDE
{
  clickFirstToggle()
  return
}
clickAndBack(260, 380)
return
^1::clickAndBack(30, 105)
^2::clickAndBack(30, 160)
^3::clickAndBack(30, 200)

^,::
WinGetPos, , , , h, A
click1 := [30, h - 25]
click2 := [70, 65]
multipleClickAndBack([ click1, click2 ])
return

!1::clickWXworkChatItem(0)
!2::clickWXworkChatItem(1)
!3::clickWXworkChatItem(2)
!4::clickWXworkChatItem(3)
!5::clickWXworkChatItem(4)
!6::clickWXworkChatItem(5)
!7::clickWXworkChatItem(6)
!8::clickWXworkChatItem(7)
!9::clickWXworkChatItem(8)

#IfWinActive ahk_class ChatWnd
!s::sendSticker()

#IfWinActive ahk_class AddMemberWnd
!x::clickAndBack(45, 20)

#IfWinActive, ahk_class SelectContactWnd
!x::clickAndBack(45, 20)

#IfWinActive ahk_class ImagePreviewWnd
r::
WinGetPos, , , w, h, A
clickAndBack(w / 2 + 60, h - 40)
return

s::Send ^s
j::Send {Right}
k::Send {Left}

#IfWinActive ahk_class CefWebViewWnd
!x::
WinGetPos, , , w
clickAndBack(w - 25, 65)
return

; Clean up the directive to avoid messing up with other code
#ifwinactive
