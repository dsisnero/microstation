ption Explicit
' ---------------------------------------------------------------------
Private Const MODULE_NAME                   As String = "modMain"
Private Const VERSION_                      As String = "17.2.5.1"
Private Const REWRITE_ELEMENT               As Boolean = True
' ---------------------------------------------------------------------
'   Notice:
'
'   VBA project TextReplacer is provided as-is with no guarantee of
'   suitability for purpose.  TextReplacer is provided as FreeWare.
'   No copyright is claimed and no license fee is payable.
'   Use at your own risk.
'
'   TextReplacer is provided to demonstrate the use of MicroStation VBA
'   to solve a particular task.  The question asked was "How do I use a
'   Regular Expression to find and replace text in a DGN model?"
'
'   It shows how to find and replace text in several element types...
'       Text elements
'       Text Node elements
'       Cell elements
'       Tag elements
'
'   TextReplacer.mvba was developed by LA Solutions Ltd.
'   Visit our web site:
'   www.la-solutions.co.uk
'
'   You may use this sample code for any purpose provided that this notice
'   is retained in full.
'
'   End of Notice
' ---------------------------------------------------------------------
'   References
'
'   This project references libraries
'   Microsoft Scripting Runtime
'   Microsoft VBScript Regular Expressions 5.5
'   See article
'   http://www.la-solutions.co.uk/content/MVBA/MVBA-RegEx.htm
' ---------------------------------------------------------------------
'   Main entry point
'   key-in:
'   vba run [TextReplacer]modMain.Main
' ---------------------------------------------------------------------
Public Sub Main()
    On Error GoTo err_Main
    Debug.Print "[TextReplacer]modMain.Main version " & Version()
    frmTextReplacer.Show vbModeless
    Exit Sub
    
err_Main:
    ReportError MODULE_NAME, "Main"
End Sub
' ---------------------------------------------------------------------
Public Function Version() As String
    Version = VERSION_
End Function
' ---------------------------------------------------------------------
'   GetMatchesFromEnumeration
'   We're given an ElementEnumerator of words.  The source of that
'   enumerator could be from a selection set, fence contents, or model scan.
'   Compare each word with the RegEx.  If there is a match, add it to
'   a VB dictionary, indexed by the element ID.
'   Returns:    Long count of matched words
' ---------------------------------------------------------------------
Private Function GetMatchesFromEnumeration( _
        ByVal oMatches As Scripting.Dictionary, _
        ByVal oWords As ElementEnumerator, _
        ByVal oRegEx As VBScript_RegExp_55.RegExp, _
        ByVal substitute As String, _
        ByVal scanText As Boolean, _
        ByVal scanNodes As Boolean, _
        ByVal scanTags As Boolean, _
        ByVal scanCells As Boolean, _
        ByVal replace As Boolean) As Long
    GetMatchesFromEnumeration = 0
    On Error GoTo err_GetMatchesFromEnumeration
    
    Dim nWords                              As Long
    Dim nMatches                            As Long
    Dim descr                               As String
    Do While oWords.MoveNext
        nMatches = 0
        If scanText And oWords.Current.IsTextElement Then
            Dim oText                       As TextElement
            Set oText = oWords.Current.AsTextElement
            If replace Then
                nMatches = ReplaceText(oText, substitute, oRegEx)
                nWords = nWords + nMatches
            Else
                nMatches = MatchText(oText.Text, oRegEx)
                nWords = nWords + nMatches
            End If
            If 0 < nMatches Then descr = "Text Element"
        ElseIf scanNodes And oWords.Current.IsTextNodeElement Then
            Dim oNode                       As TextNodeElement
            Set oNode = oWords.Current.AsTextNodeElement
            If replace Then
                nMatches = ReplaceTextInNode(oNode, substitute, oRegEx, REWRITE_ELEMENT)
                nWords = nWords + nMatches
            Else
                nMatches = MatchTextNode(oNode, oRegEx)
                nWords = nWords + nMatches
            End If
            If 0 < nMatches Then descr = "Text Node Element"
        ElseIf scanTags And oWords.Current.IsTagElement Then
            Dim oTag                        As TagElement
            Set oTag = oWords.Current.AsTagElement
            If IsTextTag(oTag) Then
                If replace Then
                    nMatches = ReplaceTextInTag(oTag, substitute, oRegEx)
                    nWords = nWords + nMatches
                Else
                    nMatches = MatchText(CStr(oTag.Value), oRegEx)
                    nWords = nWords + nMatches
                End If
            End If
            If 0 < nMatches Then descr = "Tag Element"
        ElseIf scanCells And oWords.Current.IsCellElement Then
            Dim oCell                       As CellElement
            Set oCell = oWords.Current.AsCellElement
            If replace Then
                nMatches = ReplaceTextInCell(oCell, substitute, oRegEx)
                nWords = nWords + nMatches
            Else
                nMatches = MatchTextInCell(oCell, oRegEx)
                nWords = nWords + nMatches
            End If
            If 0 < nMatches Then descr = "Cell Element"
        End If
        If nMatches And Not oMatches Is Nothing Then
            oMatches.Add DLongToString(oWords.Current.id), descr
        End If
    Loop
    GetMatchesFromEnumeration = nWords
    Exit Function
    
err_GetMatchesFromEnumeration:
    ReportError MODULE_NAME, "GetMatchesFromEnumeration"
End Function
' ---------------------------------------------------------------------
'   ScanForText
'   Scan the specified model for text elements whose content matches
'   the regular expression pattern.
'   If a select set is active, examine the contents of that selection set;
'   If a fence is active, examine the contents of that fence;
'   Otherwise, scan the active model.
'   The relevant information is stored in a VB Dictionary.
'   Returns:    Count of matched text elements
' ---------------------------------------------------------------------
Public Function ScanForText( _
        ByVal oMatches As Scripting.Dictionary, _
        ByVal oRegEx As VBScript_RegExp_55.RegExp, _
        ByVal substitute As String, _
        ByVal oModel As ModelReference, _
        ByVal scanText As Boolean, _
        ByVal scanNodes As Boolean, _
        ByVal scanTags As Boolean, _
        ByVal scanCells As Boolean, _
        ByVal replace As Boolean) As Long
    ScanForText = 0
    On Error GoTo err_ScanForText
    
    If scanText Then Debug.Print "Scanning for text elements"
    If scanNodes Then Debug.Print "Scanning text nodes"
    If scanTags Then Debug.Print "Scanning for tag elements"
    If scanCells Then Debug.Print "Scanning for text in cells"
   
    Dim usingSelection                      As Boolean
    usingSelection = False
    Dim usingFence                          As Boolean
    usingFence = False
    
    Dim msg                                 As String
    Dim oWords                              As ElementEnumerator
    If oModel.AnyElementsSelected Then
        Set oWords = oModel.GetSelectedElements()
        usingSelection = True
    Else
        Dim oFence                          As Fence
        Set oFence = ActiveDesignFile.Fence
        If oFence.IsDefined Then
            Set oWords = oFence.GetContents()
            usingFence = True
        Else
            Dim oCriteria                   As New ElementScanCriteria
            oCriteria.ExcludeAllTypes
            If scanText Then oCriteria.IncludeType msdElementTypeText
            If scanNodes Then oCriteria.IncludeType msdElementTypeTextNode
            If scanTags Then oCriteria.IncludeType msdElementTypeTag
            If scanCells Then oCriteria.IncludeType msdElementTypeCellHeader
            Set oWords = oModel.Scan(oCriteria)
        End If
    End If
    '   We have an enumeration of text elements gathered from one of select set, fence or active model
    Dim nWords                              As Long
    nWords = GetMatchesFromEnumeration(oMatches, oWords, oRegEx, substitute, scanText, scanNodes, scanTags, scanCells, replace)
    If (0 = nWords) Then
        msg = "No text was found matching " & SingleQuote(oRegEx.pattern)
        ShowMessage msg, msg, msdMessageCenterPriorityWarning, True
    Else
        ScanForText = nWords
        msg = "Matched " & CStr(nWords) & " elements"
        If usingSelection Then msg = msg & " in selection set"
        If usingFence Then msg = msg & " in fence"
        ShowMessage msg, msg, msdMessageCenterPriorityInfo, False
    End If
    
    Exit Function
    
err_ScanForText:
    ReportError MODULE_NAME, "ScanForText"
End Function
' ---------------------------------------------------------------------
'   IsTextTag
'   Determine the data type stored in this tag element.
'   Data type may be text, real or integer or some binary type.
'   We must retrieve the tag set definition in order to find
'   the tag's data type
'   Returns:    True if the tag stores text
' ---------------------------------------------------------------------
Public Function IsTextTag(ByVal oTag As TagElement) As Boolean
    IsTextTag = False
    On Error GoTo err_IsTextTag
    Dim oSet                                As TagSet
    Set oSet = ActiveDesignFile.TagSets(oTag.TagSetName)
    Dim oTagDef                             As TagDefinition
    Set oTagDef = oSet.TagDefinitions(oTag.TagDefinitionName)
    IsTextTag = (oTagDef.TagType = msdTagTypeCharacter)
    Exit Function
    
err_IsTextTag:
    ReportError MODULE_NAME, "IsTextTag"
End Function
' ---------------------------------------------------------------------
'   ReplaceTextInCell
'   Search a cell for text strings that match a regular expression, then
'   substitute the replacement text for each match
'   Returns:    Long count of matched text elements
' ---------------------------------------------------------------------
Private Function ReplaceTextInCell(ByVal oCell As CellElement, ByVal replacement As String, ByVal oRegEx As VBScript_RegExp_55.RegExp) As Long
    ReplaceTextInCell = 0
    On Error GoTo err_ReplaceTextInCell
    Const Nested                            As Boolean = True
    Dim nestLevel                           As Long
    nestLevel = 0
    Dim nWords                              As Long
    nWords = MatchTextInCell(oCell, oRegEx)
    If 0 < nWords Then
        nWords = 0
        oCell.ResetElementEnumeration
        Do While oCell.MoveToNextElement(Nested, nestLevel)
            Dim nChanges                    As Long
            nChanges = 0
            Dim oElement                    As Element
            Set oElement = oCell.CopyCurrentElement()
            If oElement.IsTextElement Then
                Dim oText                   As TextElement
                Set oText = oElement.AsTextElement
                nChanges = ReplaceText(oText, replacement, oRegEx)
                If 0 < nChanges Then
                    oCell.ReplaceCurrentElement oText
                    nWords = nWords + nChanges
                End If
            ElseIf oElement.IsTextNodeElement Then
                Dim oNode                   As TextNodeElement
                Set oNode = oElement.AsTextNodeElement
                Dim oNewNode                As TextNodeElement
                Set oNewNode = oNode.Clone
                nChanges = ReplaceTextInNode(oNewNode, replacement, oRegEx, Not REWRITE_ELEMENT)
                If 0 < nChanges Then
                    oCell.ReplaceCurrentElement oNewNode
                    nWords = nWords + nChanges
                End If
           End If
        Loop
        If 0 < nChanges Then
            oCell.rewrite
        End If
    End If
    ReplaceTextInCell = nWords
    Exit Function
    
err_ReplaceTextInCell:
    ReportError MODULE_NAME, "ScanForText"
End Function
' ---------------------------------------------------------------------
'   MatchTextInCell
'   For each text element in a cell element, test its content using the
'   supplied regular expression
'   Returns:    Long count of matched text elements
' ---------------------------------------------------------------------
Private Function MatchTextInCell(ByVal oCell As CellElement, ByVal oRegEx As VBScript_RegExp_55.RegExp) As Long
    MatchTextInCell = 0
    On Error GoTo err_MatchTextInCell
    Debug.Print "Analysing cell " & SingleQuote(oCell.Name)
    MatchTextInCell = EvaluateTextComponents(oCell.GetSubElements, oRegEx)
    Exit Function
    
err_MatchTextInCell:
    ReportError MODULE_NAME, "MatchTextInCell"
End Function
' ---------------------------------------------------------------------
'   ReplaceTextInTag
'   Test a string using the supplied regular expressions
'   Returns:    Long count of matched sub-strings
' ---------------------------------------------------------------------
Public Function ReplaceTextInTag(ByVal oTag As TagElement, ByVal replacement As String, ByVal oRegEx As VBScript_RegExp_55.RegExp) As Long
    ReplaceTextInTag = 0
    Debug.Assert IsTextTag(oTag)
    Dim tagValue                            As String
    tagValue = CStr(oTag.Value)
    Dim nReplacements                       As Long
    nReplacements = MatchText(tagValue, oRegEx)
    Dim result                              As String
    result = oRegEx.replace(tagValue, replacement)
    oTag.Value = result
    oTag.rewrite
    Debug.Print "RegEx.Replace " & SingleQuote(tagValue) & " with " & SingleQuote(replacement) & " result " & SingleQuote(result)
    Debug.Print "Replaced " & CStr(nReplacements) & " sub-strings in " & SingleQuote(tagValue)
    ReplaceTextInTag = nReplacements
End Function
' ---------------------------------------------------------------------
'   ReplaceTextInNode
'   Search and replace text in each text element in a text node element
'   Returns:    Long count of matched text elements
' ---------------------------------------------------------------------
Private Function ReplaceTextInNode( _
        ByVal oNode As TextNodeElement, _
        ByVal replacement As String, _
        ByVal oRegEx As VBScript_RegExp_55.RegExp, _
        ByVal rewrite As Boolean) As Long
    ReplaceTextInNode = 0
    On Error GoTo err_ReplaceTextInNode
    '   Find how many substitutions will be made
    Dim nReplaced                           As Long
    nReplaced = EvaluateTextComponents(oNode.GetSubElements, oRegEx)
    If 0 < nReplaced Then
        Dim nWords                          As Long
        nWords = oNode.TextLinesCount
        Dim word                            As Long
        For word = 1 To nWords
            Dim result                      As String
            result = oRegEx.replace(oNode.TextLine(word), replacement)
            '   This assigment fails
            oNode.TextLine(word) = result
        Next word
        If rewrite Then oNode.rewrite
    End If
    ReplaceTextInNode = nReplaced
    Exit Function
    
err_ReplaceTextInNode:
    ReportError MODULE_NAME, "ReplaceTextInNode"
End Function
' ---------------------------------------------------------------------
'   MatchTextNode
'   For each text element in a text node, test its content using the
'   supplied regular expression
'   Returns:    Long count of matched text elements
' ---------------------------------------------------------------------
Private Function MatchTextNode(ByVal oNode As TextNodeElement, ByVal oRegEx As VBScript_RegExp_55.RegExp) As Long
    MatchTextNode = 0
    On Error GoTo err_MatchTextNode
    MatchTextNode = EvaluateTextComponents(oNode.GetSubElements, oRegEx)
    Exit Function
    
err_MatchTextNode:
    ReportError MODULE_NAME, "MatchTextNode"
End Function
' ---------------------------------------------------------------------
'   EvaluateTextComponents
'   Given an ElementEnumerator, test each TextElement using the
'   supplied regular expression
'   Returns:    Long count of matching text in the ElementEnumerator
' ---------------------------------------------------------------------
Private Function EvaluateTextComponents(ByVal oEnumerator As ElementEnumerator, ByVal oRegEx As VBScript_RegExp_55.RegExp) As Long
    EvaluateTextComponents = 0
    On Error GoTo err_EvaluateTextComponents
    Dim nWords                              As Long
    nWords = 0
    Do While oEnumerator.MoveNext
        'Debug.Print "Current element type " & CStr(oEnumerator.Current.Type)
        If oEnumerator.Current.IsTextElement Then
            nWords = nWords + MatchText(oEnumerator.Current.AsTextElement.Text, oRegEx)
        ElseIf oEnumerator.Current.IsTextNodeElement Then
            nWords = nWords + EvaluateTextComponents(oEnumerator.Current.AsTextNodeElement.GetSubElements, oRegEx)
        End If
    Loop
    EvaluateTextComponents = nWords
    Exit Function
    
err_EvaluateTextComponents:
    ReportError MODULE_NAME, "EvaluateTextComponents"
End Function
' ---------------------------------------------------------------------
'   FocusElement
'   Focus the specified view on the element having the passed Element ID
' ---------------------------------------------------------------------
Public Function FocusElement(ByRef id As DLong, ByVal nView As Long) As Boolean
    FocusElement = False
    On Error GoTo err_FocusElement
    Debug.Print "FocusElement ID=" & DLongToString(id)
    Dim oTarget                             As Element
    Set oTarget = ActiveModelReference.GetElementByID(id)
    Debug.Assert Not oTarget Is Nothing
    Debug.Print "Found element ID " & DLongToString(id) & " type=" & CStr(oTarget.Type)
    FocusElement = ZoomToElement(oTarget, nView)
    Exit Function

err_FocusElement:
    ReportError MODULE_NAME, "FocusElement"
End Function
' ---------------------------------------------------------------------
'   ZoomToElement
'   See published article:
'   http://www.la-solutions.co.uk/content/MVBA/MVBA-ElementLocator.htm#FindElementById
' ---------------------------------------------------------------------
Function ZoomToElement(ByVal oTarget As Element, ByVal nView As Integer) As Boolean
    ZoomToElement = False
    If (oTarget.IsGraphical) Then
        Const Zoom                          As Double = 4
        Dim range                           As Range3d
        range = oTarget.range
        Dim oView                           As view
        Set oView = ActiveDesignFile.Views.Item(nView)
        Dim extent                          As Point3d
        extent = Point3dScale(Point3dSubtract(range.High, range.Low), Zoom)
        oView.Origin = Point3dSubtract(range.Low, Point3dScale(extent, 0.5))
        oView.Extents = extent
        oView.Redraw
        oTarget.IsHighlighted = True
    Else
        MsgBox "Element having ID " & DLongToString(oTarget.id) & " is not a graphical element", vbOKOnly Or vbInformation, "Invalid Element"
    End If
    Exit Function

err_ZoomToElement:
    ReportError MODULE_NAME, "ZoomToElement"
End Function
' ---------------------------------------------------------------------
'   AddToSelectionSet
'   Add an element to the current selection set
' ---------------------------------------------------------------------
Public Sub AddToSelectionSet(ByRef id As DLong, ByVal oModel As ModelReference)
    Debug.Print "AddToSelectionSet ID " & DLongToString(id)
    Dim oElement                            As Element
    Set oElement = oModel.GetElementByID(id)
    oModel.SelectElement oElement
End Sub
' ---------------------------------------------------------------------
Public Function DoubleQuote(ByVal s As String) As String
    DoubleQuote = Wrap(s, """")
End Function
' ---------------------------------------------------------------------
Public Function SingleQuote(ByVal s As String) As String
    SingleQuote = Wrap(s, "'")
End Function
' ---------------------------------------------------------------------
Private Function Wrap(ByVal s As String, ByVal delimeter As String) As String
    Wrap = delimeter & s & delimeter
End Function
' ---------------------------------------------------------------------
'   ReportError
'   Report errors in a consistent manner
' ---------------------------------------------------------------------
Public Sub ReportError(ByVal moduleName As String, ByVal procName As String)
    MsgBox "Error no. " & CStr(Err.Number) & ": " & Err.Description & vbNewLine & "Caused by " & Err.Source, vbOKOnly Or vbExclamation, "Error in " & moduleName & ":" & procName
End Sub
' ---------------------------------------------------------------------

