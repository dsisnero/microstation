module Microstation
  class Cell < Element
    def initialize(*args)
      super(*args)
      @should_replace = false
      @replacement = nil
    end

    def shared_cell?
      ole_obj.IsSharedCellElement
    end

    def name
      ole_obj.Name
    end

    def text_elements
      return to_enum(:text_elements) unless block_given?

      each do |el|
        yield el if el.textual?
      end
    end
  end
end

#   def each
#     return enum_for(:each) unless block_given?
#     ole_enum = @ole_obj.GetSubElements
#     while ole_enum.MoveNext
#       item = ole_enum.Currentq
#       wrapped = Microstation::Wrap.wrap(item,app)

#       yield
#     end
#   end

#   def each_ole(ole)
#     ole_enum = ole.GetSubElements
#     while ole_enum.MoveNext
#       item = ole_enum.Current
#       if item.IsComplexElement
#         each_ole(item)
#       else

#       wrapped = Microstation::Wrap.wrap(item,app)

#       yield
#     end
# end

# def each_ole(ole)
#   ole_enum = ole.GetSubElements
#   end

#   def gsub_text(regex,replacement)
#     each do |current|
#       next unless temp_el.textual?
#       temp_el.gsub!(regex,replacement)
#       replace_current_with(temp_el)
#     end
#   end

#   def replace_current_with(this_var)
#     this_var = this_var.ole_obj if this_var.respond_to? :ole_obj
#     ole_obj.ReplaceCurrentElement this_var
#   end

#  Dim search_text As String
#  Dim replace_text As String

# Private Function ReplaceTextInCell(el As Element) As Boolean

#  Dim cel As CellElement
#  Dim ret As Boolean
#  Dim tel As TextElement
#  ret =  False
#     Set cel = el
#     cel.ResetElementEnumeration
#     Do While cel.MoveToNextElement(True)
#         Dim eleTemp As Element
#         Set eleTemp = cel.CopyCurrentElement
#         If eleTemp.IsTextElement Then
#             Set tel = eleTemp
#             If tel.Text = search_text Then
#                 tel.Text = replace_text
#                 ret = True
#                 cel.ReplaceCurrentElement tel
#             End If
#         End If
#     Loop
#     ReplaceTextInCell = ret
# End Function

# Public Sub ReplaceAllTextsInModel()

#  'USE THIS TO SET THE REPLACEMENT BY CONFIGURATION VARIABLE
#  'search_text = ActiveWorkspace.ExpandConfigurationVariable("SEARCH_TEXT")
#  'replace_text = ActiveWorkspace.ExpandConfigurationVariable("REPLACE_TEXT")
#  search_text = "Test"
#  replace_text = "Blubber"
#  Dim e As ElementEnumerator
#  Dim es As ElementScanCriteria
#  Dim el As Element
#  Set es = New ElementScanCriteria

#  Set e = ActiveModelReference.Scan(es)
#  Do While e.MoveNext
#     Set el = e.Current
#     If (el.IsCellElement) Then
#         If ReplaceTextInCell(el) Then
#           el.Rewrite
#         End If
#     End If
#  Loop
# End Sub

# Option Explicit
#     ' Searches in text strings and nested cells

#     Private sToFind As String       ' Find text
#     Private sToReplace As String    ' Replace with this text
#     Private isComplex As Boolean

# Sub TxtRep_complex()
#     Dim CmdLine() As String
#     Dim Ee As ElementEnumerator
#     Dim Sc As New ElementScanCriteria

#     ' As a separator between parameters, "|" is used.
#     CmdLine = Split(KeyinArguments, "|")
#     ' Cancel if incorrect parameters are given:
#     If UBound(CmdLine) < 1 Then  ' no parameter given
#         MessageCenter.AddMessage "Replace Text: Missing Parameters, see details:", "Call was made with: " + KeyinArguments, msdMessageCenterPriorityError
#         Exit Sub
#     End If

#     sToFind = Trim(CmdLine(0))      '1. Parameter for search text
#     sToReplace = Trim(CmdLine(1))   '2. Parameter for new text
#     ' Check if optional parameter = yes complex was given
#     isComplex = False
#     If UBound(CmdLine) > 1 Then
#         If InStr(CmdLine(2), "complex") > 0 And InStr(CmdLine(2), "yes") > 0 Then isComplex = True
#     End If

#     ' If not looking at cells, only filter texts and text nodes:
#     If isComplex = False Then
#         Sc.ExcludeAllTypes
#         Sc.IncludeType msdElementTypeText
#         Sc.IncludeType msdElementTypeTextNode   ' Also text node always search
#     Else
#         Sc.ExcludeNonGraphical
#     End If

#     Set Ee = ActiveModelReference.Scan(Sc)
#     ' Browse current model and start the test routine:
#     Do While Ee.MoveNext
#         Call complexSearch(Ee.Current)
#     Loop
# End Sub
# ' Subroutine for recursively browsing nested complex elements
# Sub complexSearch(oEle As Element)
#     Dim EeSub As ElementEnumerator
#     ' If a complex element or text node is found, check all sub-elements:
#     If (oEle.IsComplexElement And isComplex) Or (oEle.Type = msdElementTypeTextNode) Then
#         Set EeSub = oEle.AsComplexElement.GetSubElements
#         Do While EeSub.MoveNext
#             Call complexSearch(EeSub.Current)
#         Loop
#     ' Otherwise string compare, if a text is present:
#     Else
#         If oEle.Type = msdElementTypeText Then
#             If oEle.AsTextElement.Text = sToFind Then
#                oEle.AsTextElement.Text = sToReplace
#                oEle.Rewrite
#             End If
#         End If
#     End If
# # End Sub
