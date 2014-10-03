Option Explicit
Dim reportWorkbook As Excel.Workbook
Dim itemMasterWorkbook As Excel.Workbook
Private itemCategoryArray() As String
Private itemArray() As String
Private descArray() As String
Dim prefabFastenerArray() As Variant
Dim fastenerArray() As Variant
Dim safetyArray() As Variant
Dim miscArray() As Variant
Dim tubeLaserArray() As Variant
Dim miterCutArray() As Variant
Dim sawCutArray() As Variant
Dim parts As Variant
Dim items As Variant
Dim itemNumbers() As String
Dim inventoryParts() As String
Dim PlumberColor As String
Dim combiRopeColor As String
Dim jobNumber As String
Dim Customer As String
Dim Reference As String
Dim area07 As Long
Dim area1196
Dim area125 As Long
Dim area1875 As Long
Dim area3125 As Long
Dim area25 As Long
Dim area375 As Long
Dim area5 As Long
Dim area625 As Long
Dim area75 As Long
Dim area875 As Long
Dim area1 As Long
Dim areau As Long

Sub InventoryMacro()

 '======== Do Not update the UI as the report is built
  Application.ScreenUpdating = False
'========== need a handle on the BOM, which should be open when running the macro

'========= Get Item Master Workbook =============
    Set itemMasterWorkbook = Workbooks.Open("ItemMaster.xlsx")
    Call sBuildItemArray
    itemMasterWorkbook.Close
    
    '======== prompt user for customer , plumber and rope colors ============
  UserForm.Show
  jobNumber = Left(ActiveWorkbook.Name, 4)
  PlumberColor = UserForm.PlumberColor
  combiRopeColor = UserForm.RopeColor
  Customer = UserForm.Customer
  
   '========== Create an array of all parts into a multidimensional array ========
    Call PartsArray
    
'================= Instantiate the variables required when looping through the parts array =======
   Dim catergory As String
   Dim description As String
   Dim combiRope As Double
   combiRope = 0
   
   'set plasma variables
    area07 = 0
    area1196 = 0
    area125 = 0
   area1875 = 0
   area25 = 0
   area3125 = 0
   area375 = 0
   area5 = 0
   area625 = 0
   area75 = 0
   area875 = 0
   area1 = 0
  area875 = 0
   areau = 0
   
   'The plumber variables

   Dim plbRound, plb22, plb24, plb26, plb44 As Double
   plbRound = 0
   plb22 = 0
   plb24 = 0
   plb26 = 0
   plb44 = 0
   
   'raw stock variables
   Dim rawStock As Double
   rawStock = 0
   
   'redim prefabArray
   ReDim prefabFastenerArray(0)
   ReDim fastenerArray(0)
   ReDim safetyArray(0)
   ReDim miscArray(0)
   ReDim tubeLaserArray(0)
   ReDim miterCutArray(0)
   ReDim sawCutArray(0)
    
    '==================== iterate through all of the parts  the array =================
    Dim i As Integer
    For i = 1 To UBound(parts)
        description = Replace(parts(i, 9), Chr(34), "") 'strip out the quotes from the description position in the 2nd dimension of the array
        description = Replace(description, ",", "")
    
        catergory = parts(i, 10) 'the category is in position 10 of the 2nd dimension of the array

        Select Case catergory
    
            Case "COMBI-ROPE"
                'total up all of the combi rope using length * qty. There is no differentiation as it is all the same
                combiRope = combiRope + ((parts(i, 5) * parts(i, 13)) / 12)
               
            Case "LUMBER"
            'total up each of the sizes of plumber
                If InStr(description, "RND") > 0 Then
                    plbRound = plbRound + ((parts(i, 5) * parts(i, 13)) / 12)
                End If
                
                 If InStr(description, "LPL2X6") > 0 Then
                    plb26 = plb26 + ((parts(i, 5) * parts(i, 13)) / 12)
                End If
                
                If InStr(description, "LPL2X4") > 0 Then
                    plb24 = plb24 + ((parts(i, 5) * parts(i, 13)) / 12)
                End If
                
                If InStr(description, "2X2") > 0 Then
                    plb22 = plb22 + ((parts(i, 5) * parts(i, 13)) / 12)
                End If
                
                If InStr(description, "4X4") > 0 Then
                    plb44 = plb44 + ((parts(i, 5) * parts(i, 13)) / 12)
                End If
                
        Case "TRACK RAW STOCK"
            'how many sticks of raw track stock at 23'  each
            rawStock = rawStock + (((parts(i, 5) * parts(i, 13)) / 12) / 23)
  
        Case "PREFAB-FASTENER"
            prefabFastenerArray(UBound(prefabFastenerArray)) = CStr(parts(i, 2)) + "," + CStr(parts(i, 5)) + "," + description
            ReDim Preserve prefabFastenerArray(UBound(prefabFastenerArray) + 1)
            'with this array I need to compare the results of the first position with the item master and keep only those items that are inventoried items
            
        Case "PLASMA CUT"
        Call SquareInches(i, CDbl(parts(i, 5)), CStr(parts(i, 12)), CDbl(parts(i, 13)))
              
        Case "MITER CUT"
        Case "SAW CUT"
        Case "TUBE LASER"
        
        Case "SAFETY"
          safetyArray(UBound(safetyArray)) = CStr(parts(i, 2)) + "," + CStr(parts(i, 5)) + "," + description
            ReDim Preserve safetyArray(UBound(safetyArray) + 1)
            
        Case "FASTENER"
             fastenerArray(UBound(fastenerArray)) = CStr(parts(i, 2)) + "," + CStr(parts(i, 5)) + "," + description
            ReDim Preserve fastenerArray(UBound(fastenerArray) + 1)
            
        Case "DOCS"
           miscArray(UBound(miscArray)) = CStr(parts(i, 2)) + "," + CStr(parts(i, 5)) + "," + description
            ReDim Preserve miscArray(UBound(miscArray) + 1)
            
        Case "MACHINED"
           miscArray(UBound(miscArray)) = CStr(parts(i, 2)) + "," + CStr(parts(i, 5)) + "," + description
            ReDim Preserve miscArray(UBound(miscArray) + 1)
            
        Case "MISC"
        miscArray(UBound(miscArray)) = CStr(parts(i, 2)) + "," + CStr(parts(i, 5)) + "," + description
            ReDim Preserve miscArray(UBound(miscArray) + 1)

        Case "UHMW"
            miscArray(UBound(miscArray)) = CStr(parts(i, 2)) + "," + CStr(parts(i, 5)) + "," + description
            ReDim Preserve miscArray(UBound(miscArray) + 1)
            
        Case Else
            miscArray(UBound(miscArray)) = CStr(parts(i, 2)) + "," + CStr(parts(i, 5)) + "," + description
            ReDim Preserve miscArray(UBound(miscArray) + 1)
            
        End Select
    Next

'remove last empty positions from arrays
If UBound(prefabFastenerArray) > 0 Then
ReDim Preserve prefabFastenerArray(UBound(prefabFastenerArray) - 1)
End If

If UBound(fastenerArray) > 0 Then
ReDim Preserve fastenerArray(UBound(fastenerArray) - 1)
End If

If UBound(safetyArray) > 0 Then
ReDim Preserve safetyArray(UBound(safetyArray) - 1)
End If

If UBound(miscArray) > 0 Then
ReDim Preserve miscArray(UBound(miscArray) - 1)
End If

Call matchInventoryParts
'now that we have all of the data let's add it to the report
'=========== Create New Workbook ==============
    Set reportWorkbook = Workbooks.Add
    reportWorkbook.Activate
    reportWorkbook.Worksheets().Add().Name = "Inventory Report"
    
     ActiveSheet.Range(Cells(1, 1), Cells(1, 1)).ColumnWidth = 2 'spacer column
    ActiveSheet.Range(Cells(1, 2), Cells(1, 2)).ColumnWidth = 20 'Item
    ActiveSheet.Range(Cells(1, 3), Cells(1, 3)).ColumnWidth = 30 'Description
    ActiveSheet.Range(Cells(1, 4), Cells(1, 4)).ColumnWidth = 30 'Qty
   ActiveSheet.Range(Cells(1, 5), Cells(1, 5)).ColumnWidth = 12 'Qty
   ActiveSheet.Range(Cells(1, 6), Cells(1, 6)).ColumnWidth = 2 'Qty
    
  '========== setup page ====================
  
   With ActiveSheet.PageSetup
      .Orientation = xlPortrait
      .LeftMargin = Application.InchesToPoints(0.25)
      .RightMargin = Application.InchesToPoints(0.1)
      .TopMargin = Application.InchesToPoints(0.5)
      .BottomMargin = Application.InchesToPoints(0.75)
      .HeaderMargin = Application.InchesToPoints(0.2)
      .FooterMargin = Application.InchesToPoints(0.1)
       .PrintArea = "$B:$E"  'all I need to set is the columns
      .FitToPagesWide = 1 'this does not seem to work in windows excel 2007
  End With
  
  '  ============= set footer ========================'
  ActiveSheet.PageSetup.LeftFooter = "&G"
  ActiveSheet.PageSetup.RightFooter = "&""Myriad Pro Condensed""&14" & "Page " & "&P" & " of " & "&N"
    
    Dim counter As Integer
    counter = 1
    
    With ActiveSheet.Range(Cells(counter, 1), Cells(counter, 3))
        .Merge
        .HorizontalAlignment = xlLeft
        .Font.Bold = True
        .Interior.ColorIndex = 0
        .Font.Color = vbBlack
        .Font.Size = 14
        .Borders(xlEdgeTop).LineStyle = xlContinuous
        .Borders(xlEdgeBottom).LineStyle = xlContinuous
        .Value = "Effective Date: " & Date
    End With
    
    With ActiveSheet.Range(Cells(counter, 4), Cells(counter, 6))
        .Merge
         .HorizontalAlignment = xlLeft
        .Font.Bold = True
        .Interior.ColorIndex = 0
        .Font.Color = vbBlack
        .Font.Size = 14
        .Borders(xlEdgeTop).LineStyle = xlContinuous
        .Borders(xlEdgeBottom).LineStyle = xlContinuous
        .Value = "Reference Number: " & Reference
    End With
    
    counter = 3
    
     With ActiveSheet.Range(Cells(counter, 1), Cells(counter, 6))
        .Merge
         .HorizontalAlignment = xlCenter
        .Font.Bold = True
        .Interior.ColorIndex = 1
        .Font.Color = vbWhite
        .Font.Size = 20
        .Borders(xlEdgeTop).LineStyle = xlContinuous
        .Borders(xlEdgeBottom).LineStyle = xlContinuous
        .Value = Customer & " " & "- " & jobNumber & " Inventory Report  "
    End With
     
     'Plastic Lumber
     counter = 5
     
     Select Case PlumberColor
    Case "Red"
        With ActiveSheet.Range(Cells(counter, 1), Cells(counter, 6))
               .Interior.ColorIndex = 3
                .Font.Color = vbWhite
        End With
        
     Case "Blue"
        With ActiveSheet.Range(Cells(counter, 1), Cells(counter, 6))
               .Interior.ColorIndex = 5
                .Font.Color = vbWhite
        End With
        
        Case "Green"
        With ActiveSheet.Range(Cells(counter, 1), Cells(counter, 6))
               .Interior.ColorIndex = 10
                .Font.Color = vbWhite
        End With
        
        Case "Cedar"
        With ActiveSheet.Range(Cells(counter, 1), Cells(counter, 6))
               .Interior.ColorIndex = 40
                .Font.Color = vbBlack
        End With
        
         Case "Gray"
        With ActiveSheet.Range(Cells(counter, 1), Cells(counter, 6))
               .Interior.ColorIndex = 16
                .Font.Color = vbWhite
        End With
        
        Case Else
        
        With ActiveSheet.Range(Cells(counter, 1), Cells(counter, 6))
               .Interior.ColorIndex = 1
                .Font.Color = vbWhite
        End With
        
    End Select
    With ActiveSheet.Range(Cells(counter, 1), Cells(counter, 6))
        .Merge
         .HorizontalAlignment = xlCenter
        .Font.Bold = True
    
         .Borders(xlEdgeTop).LineStyle = xlContinuous
        .Borders(xlEdgeBottom).LineStyle = xlContinuous
        .Value = "Plastic Lumber Used"
    End With
    
    'now independently add each of the plumber rows
    'add the ccolumn headers
     With ActiveSheet.Range(Cells(counter + 1, 2), Cells(counter + 1, 2))
        .HorizontalAlignment = xlCenter
        .Font.Bold = True
        .Borders(xlEdgeBottom).LineStyle = xlContinuous
        .Value = "Part Number"
    End With
    
    With ActiveSheet.Range(Cells(counter + 1, 3), Cells(counter + 1, 3))
        .HorizontalAlignment = xlCenter
        .Font.Bold = True
        .Borders(xlEdgeBottom).LineStyle = xlContinuous
        .Value = "Color"
    End With
    
      With ActiveSheet.Range(Cells(counter + 1, 4), Cells(counter + 1, 4))
        .HorizontalAlignment = xlCenter
        .Font.Bold = True
        .Borders(xlEdgeBottom).LineStyle = xlContinuous
        .Value = "Dimensions"
    End With
    
      With ActiveSheet.Range(Cells(counter + 1, 5), Cells(counter + 1, 5))
        .HorizontalAlignment = xlCenter
        .Font.Bold = True
        .Borders(xlEdgeBottom).LineStyle = xlContinuous
        .Value = "Feet"
    End With
    
     With ActiveSheet.Range(Cells(counter + 2, 2), Cells(counter + 2, 2))
        .HorizontalAlignment = xlLeft
         .Borders(xlEdgeBottom).LineStyle = xlContinuous
         
         If PlumberColor = "Blue" Then
            .Value = "150062"
          ElseIf PlumberColor = "Cedar" Then
              .Value = "150060"
          Else
             .Value = "Other"
         End If

    End With
    
    With ActiveSheet.Range(Cells(counter + 2, 3), Cells(counter + 2, 3))
        .HorizontalAlignment = xlLeft
        .Borders(xlEdgeBottom).LineStyle = xlContinuous
        .Value = PlumberColor
    End With
    
      With ActiveSheet.Range(Cells(counter + 2, 4), Cells(counter + 2, 4))
        .HorizontalAlignment = xlLeft
        .Borders(xlEdgeBottom).LineStyle = xlContinuous
        .Value = "LPL2.313RND"
    End With
    
      With ActiveSheet.Range(Cells(counter + 2, 5), Cells(counter + 2, 5))
        .HorizontalAlignment = xlCenter
        .Borders(xlEdgeBottom).LineStyle = xlContinuous
        .Value = Ceiling(plbRound)
    End With
    
     With ActiveSheet.Range(Cells(counter + 3, 2), Cells(counter + 3, 2))
        .HorizontalAlignment = xlLeft
        .Borders(xlEdgeBottom).LineStyle = xlContinuous
        
        If PlumberColor = "Blue" Then
            .Value = "150052"
          ElseIf PlumberColor = "Cedar" Then
            .Value = "150050"
          Else
             .Value = "Other"
         End If
    End With
    
    With ActiveSheet.Range(Cells(counter + 3, 3), Cells(counter + 3, 3))
        .HorizontalAlignment = xlLeft
        .Borders(xlEdgeBottom).LineStyle = xlContinuous
        .Value = PlumberColor
    End With
    
      With ActiveSheet.Range(Cells(counter + 3, 4), Cells(counter + 3, 4))
        .HorizontalAlignment = xlLeft
        .Borders(xlEdgeBottom).LineStyle = xlContinuous
        .Value = "LPL2x2"
    End With
    
      With ActiveSheet.Range(Cells(counter + 3, 5), Cells(counter + 3, 5))
        .HorizontalAlignment = xlCenter
        .Borders(xlEdgeBottom).LineStyle = xlContinuous
        .Value = Ceiling(plb22)
    End With
    
    With ActiveSheet.Range(Cells(counter + 4, 2), Cells(counter + 4, 2))
        .HorizontalAlignment = xlLeft
        .Borders(xlEdgeBottom).LineStyle = xlContinuous
        
         If PlumberColor = "Blue" Then
            .Value = "150042"
          ElseIf PlumberColor = "Cedar" Then
             .Value = "150040"
          Else
             .Value = "Other"
         End If
     
    End With
    
    With ActiveSheet.Range(Cells(counter + 4, 3), Cells(counter + 4, 3))
        .HorizontalAlignment = xlLeft
        .Borders(xlEdgeBottom).LineStyle = xlContinuous
        .Value = PlumberColor
    End With
    
      With ActiveSheet.Range(Cells(counter + 4, 4), Cells(counter + 4, 4))
        .HorizontalAlignment = xlLeft
        .Borders(xlEdgeBottom).LineStyle = xlContinuous
        .Value = "LPL2x4"
    End With
    
      With ActiveSheet.Range(Cells(counter + 4, 5), Cells(counter + 4, 5))
        .HorizontalAlignment = xlCenter
        .Borders(xlEdgeBottom).LineStyle = xlContinuous
        .Value = Ceiling(plb24)
    End With
    
     With ActiveSheet.Range(Cells(counter + 5, 2), Cells(counter + 5, 2))
        .HorizontalAlignment = xlLeft
        .Borders(xlEdgeBottom).LineStyle = xlContinuous
        If PlumberColor = "Blue" Then
            .Value = "150022"
          ElseIf PlumberColor = "Cedar" Then
             .Value = "150020"
          Else
             .Value = "Other"
         End If
        
    End With
    
    With ActiveSheet.Range(Cells(counter + 5, 3), Cells(counter + 5, 3))
        .HorizontalAlignment = xlLeft
        .Borders(xlEdgeBottom).LineStyle = xlContinuous
        .Value = PlumberColor
    End With
    
      With ActiveSheet.Range(Cells(counter + 5, 4), Cells(counter + 5, 4))
        .HorizontalAlignment = xlLeft
        .Borders(xlEdgeBottom).LineStyle = xlContinuous
        .Value = "LPL2x6"
    End With
    
      With ActiveSheet.Range(Cells(counter + 5, 5), Cells(counter + 5, 5))
        .HorizontalAlignment = xlCenter
        .Borders(xlEdgeBottom).LineStyle = xlContinuous
        .Value = Ceiling(plb26)
    End With
    
    With ActiveSheet.Range(Cells(counter + 6, 2), Cells(counter + 6, 2))
        .HorizontalAlignment = xlLeft
        .Borders(xlEdgeBottom).LineStyle = xlContinuous
        
     If PlumberColor = "Blue" Then
            .Value = "150032"
          ElseIf PlumberColor = "Cedar" Then
             .Value = "150030"
          Else
             .Value = "Other"
         End If
    End With
    
    With ActiveSheet.Range(Cells(counter + 6, 3), Cells(counter + 6, 3))
        .HorizontalAlignment = xlLeft
        .Borders(xlEdgeBottom).LineStyle = xlContinuous
        .Value = PlumberColor
    End With
    
      With ActiveSheet.Range(Cells(counter + 6, 4), Cells(counter + 6, 4))
        .HorizontalAlignment = xlLeft
        .Borders(xlEdgeBottom).LineStyle = xlContinuous
        .Value = "LPL4x4"
    End With
    
      With ActiveSheet.Range(Cells(counter + 6, 5), Cells(counter + 6, 5))
        .HorizontalAlignment = xlCenter
        .Borders(xlEdgeBottom).LineStyle = xlContinuous
        .Value = Ceiling(plb44)
    End With
    
    'Plasma Cut Plates
    counter = 13
    
    With ActiveSheet.Range(Cells(counter, 1), Cells(counter, 6))
        .Merge
         .HorizontalAlignment = xlCenter
         .Interior.ColorIndex = 1
        .Font.Color = vbWhite
        .Font.Bold = True
         .Borders(xlEdgeTop).LineStyle = xlContinuous
        .Borders(xlEdgeBottom).LineStyle = xlContinuous
        .Value = "Plasma Cut Plates"
    End With
    
     With ActiveSheet.Range(Cells(counter + 1, 2), Cells(counter + 1, 2))
        .HorizontalAlignment = xlCenter
        .Font.Bold = True
        .Borders(xlEdgeBottom).LineStyle = xlContinuous
        .Value = "Part Number"
    End With
    
    With ActiveSheet.Range(Cells(counter + 1, 3), Cells(counter + 1, 3))
        .HorizontalAlignment = xlCenter
        .Font.Bold = True
        .Borders(xlEdgeBottom).LineStyle = xlContinuous
        .Value = "Description"
    End With
    
      With ActiveSheet.Range(Cells(counter + 1, 4), Cells(counter + 1, 4))
        .HorizontalAlignment = xlCenter
        .Font.Bold = True
        .Borders(xlEdgeBottom).LineStyle = xlContinuous
        .Value = "Sheets"
    End With
    
      With ActiveSheet.Range(Cells(counter + 1, 5), Cells(counter + 1, 5))
        .HorizontalAlignment = xlCenter
        .Font.Bold = True
        .Borders(xlEdgeBottom).LineStyle = xlContinuous
        .Value = "Square Inches"
    End With
    
     With ActiveSheet.Range(Cells(counter + 2, 2), Cells(counter + 2, 2))
        .HorizontalAlignment = xlLeft
        .Borders(xlEdgeBottom).LineStyle = xlContinuous
        .Value = "PLT07P60120"
    End With
    
    With ActiveSheet.Range(Cells(counter + 2, 3), Cells(counter + 2, 3))
        .HorizontalAlignment = xlLeft
        .Borders(xlEdgeBottom).LineStyle = xlContinuous
        .Value = "14 Gauge A36 60x120"
    End With
    
      With ActiveSheet.Range(Cells(counter + 2, 4), Cells(counter + 2, 4))
        .HorizontalAlignment = xlCenter
        .Borders(xlEdgeBottom).LineStyle = xlContinuous
        .Value = Ceiling((area07 / 7200))
    End With
    
      With ActiveSheet.Range(Cells(counter + 2, 5), Cells(counter + 2, 5))
        .HorizontalAlignment = xlCenter
        .Borders(xlEdgeBottom).LineStyle = xlContinuous
        .Value = Ceiling(area07)
    End With
    
    With ActiveSheet.Range(Cells(counter + 3, 2), Cells(counter + 3, 2))
        .HorizontalAlignment = xlLeft
        .Borders(xlEdgeBottom).LineStyle = xlContinuous
        .Value = "PLT1196P60120"
    End With
    
    With ActiveSheet.Range(Cells(counter + 3, 3), Cells(counter + 3, 3))
        .HorizontalAlignment = xlLeft
        .Borders(xlEdgeBottom).LineStyle = xlContinuous
        .Value = "11 Gauge A36 60x120"
    End With
    
      With ActiveSheet.Range(Cells(counter + 3, 4), Cells(counter + 3, 4))
        .HorizontalAlignment = xlCenter
        .Borders(xlEdgeBottom).LineStyle = xlContinuous
        .Value = Ceiling((area1196 / 7200))
    End With
    
      With ActiveSheet.Range(Cells(counter + 3, 5), Cells(counter + 3, 5))
        .HorizontalAlignment = xlCenter
        .Borders(xlEdgeBottom).LineStyle = xlContinuous
        .Value = Ceiling(area1196)
    End With
    
    With ActiveSheet.Range(Cells(counter + 4, 2), Cells(counter + 4, 2))
        .HorizontalAlignment = xlLeft
        .Borders(xlEdgeBottom).LineStyle = xlContinuous
        .Value = "PLT18P60120"
    End With
    
    With ActiveSheet.Range(Cells(counter + 4, 3), Cells(counter + 4, 3))
        .HorizontalAlignment = xlLeft
        .Borders(xlEdgeBottom).LineStyle = xlContinuous
        .Value = "1/8 A36 60x120"
    End With
    
      With ActiveSheet.Range(Cells(counter + 4, 4), Cells(counter + 4, 4))
        .HorizontalAlignment = xlCenter
        .Borders(xlEdgeBottom).LineStyle = xlContinuous
        .Value = Ceiling((area125 / 7200))
    End With
    
      With ActiveSheet.Range(Cells(counter + 4, 5), Cells(counter + 4, 5))
        .HorizontalAlignment = xlCenter
        .Borders(xlEdgeBottom).LineStyle = xlContinuous
        .Value = Ceiling(area125)
    End With
    
    With ActiveSheet.Range(Cells(counter + 4, 2), Cells(counter + 4, 2))
        .HorizontalAlignment = xlLeft
        .Borders(xlEdgeBottom).LineStyle = xlContinuous
        .Value = "PLT18P60120"
    End With
    
    With ActiveSheet.Range(Cells(counter + 4, 3), Cells(counter + 4, 3))
        .HorizontalAlignment = xlLeft
        .Borders(xlEdgeBottom).LineStyle = xlContinuous
        .Value = "1/8 A36 60x120"
    End With
    
      With ActiveSheet.Range(Cells(counter + 4, 4), Cells(counter + 4, 4))
        .HorizontalAlignment = xlCenter
        .Borders(xlEdgeBottom).LineStyle = xlContinuous
        .Value = Ceiling((area125 / 7200))
    End With
    
      With ActiveSheet.Range(Cells(counter + 4, 5), Cells(counter + 4, 5))
        .HorizontalAlignment = xlCenter
        .Borders(xlEdgeBottom).LineStyle = xlContinuous
        .Value = Ceiling(area125)
    End With
    
    With ActiveSheet.Range(Cells(counter + 5, 2), Cells(counter + 5, 2))
        .HorizontalAlignment = xlLeft
        .Borders(xlEdgeBottom).LineStyle = xlContinuous
        .Value = "PLT316P60120"
    End With
    
    With ActiveSheet.Range(Cells(counter + 5, 3), Cells(counter + 5, 3))
        .HorizontalAlignment = xlLeft
        .Borders(xlEdgeBottom).LineStyle = xlContinuous
        .Value = "3/16 A36 60x120"
    End With
    
      With ActiveSheet.Range(Cells(counter + 5, 4), Cells(counter + 5, 4))
        .HorizontalAlignment = xlCenter
        .Borders(xlEdgeBottom).LineStyle = xlContinuous
        .Value = Ceiling((area1875 / 7200))
    End With
    
      With ActiveSheet.Range(Cells(counter + 5, 5), Cells(counter + 5, 5))
        .HorizontalAlignment = xlCenter
        .Borders(xlEdgeBottom).LineStyle = xlContinuous
        .Value = Ceiling(area1875)
    End With
    
    With ActiveSheet.Range(Cells(counter + 6, 2), Cells(counter + 6, 2))
        .HorizontalAlignment = xlLeft
        .Borders(xlEdgeBottom).LineStyle = xlContinuous
        .Value = "PLT14P60120"
    End With
    
    With ActiveSheet.Range(Cells(counter + 6, 3), Cells(counter + 6, 3))
        .HorizontalAlignment = xlLeft
        .Borders(xlEdgeBottom).LineStyle = xlContinuous
        .Value = "1/4 A36 60x120"
    End With
    
      With ActiveSheet.Range(Cells(counter + 6, 4), Cells(counter + 6, 4))
        .HorizontalAlignment = xlCenter
        .Borders(xlEdgeBottom).LineStyle = xlContinuous
        .Value = Ceiling((area25 / 7200))
    End With
    
      With ActiveSheet.Range(Cells(counter + 6, 5), Cells(counter + 6, 5))
        .HorizontalAlignment = xlCenter
        .Borders(xlEdgeBottom).LineStyle = xlContinuous
        .Value = Ceiling(area25)
    End With
    
     With ActiveSheet.Range(Cells(counter + 7, 2), Cells(counter + 7, 2))
        .HorizontalAlignment = xlLeft
        .Borders(xlEdgeBottom).LineStyle = xlContinuous
        .Value = "PLT516P60120"
    End With
    
    With ActiveSheet.Range(Cells(counter + 7, 3), Cells(counter + 7, 3))
        .HorizontalAlignment = xlLeft
        .Borders(xlEdgeBottom).LineStyle = xlContinuous
        .Value = "5/16 A36 60x120"
    End With
    
      With ActiveSheet.Range(Cells(counter + 7, 4), Cells(counter + 7, 4))
        .HorizontalAlignment = xlCenter
        .Borders(xlEdgeBottom).LineStyle = xlContinuous
        .Value = Ceiling((area3125 / 7200))
    End With
    
      With ActiveSheet.Range(Cells(counter + 7, 5), Cells(counter + 7, 5))
        .HorizontalAlignment = xlCenter
        .Borders(xlEdgeBottom).LineStyle = xlContinuous
        .Value = Ceiling(area3125)
    End With
    
    With ActiveSheet.Range(Cells(counter + 8, 2), Cells(counter + 8, 2))
        .HorizontalAlignment = xlLeft
        .Borders(xlEdgeBottom).LineStyle = xlContinuous
        .Value = "PLT38P60120"
    End With
    
    With ActiveSheet.Range(Cells(counter + 8, 3), Cells(counter + 8, 3))
        .HorizontalAlignment = xlLeft
        .Borders(xlEdgeBottom).LineStyle = xlContinuous
        .Value = "3/8 A36 60x120"
    End With
    
      With ActiveSheet.Range(Cells(counter + 8, 4), Cells(counter + 8, 4))
        .HorizontalAlignment = xlCenter
        .Borders(xlEdgeBottom).LineStyle = xlContinuous
        .Value = Ceiling((area375 / 7200))
    End With
    
      With ActiveSheet.Range(Cells(counter + 8, 5), Cells(counter + 8, 5))
        .HorizontalAlignment = xlCenter
        .Borders(xlEdgeBottom).LineStyle = xlContinuous
        .Value = Ceiling(area375)
    End With
    
     With ActiveSheet.Range(Cells(counter + 9, 2), Cells(counter + 9, 2))
        .HorizontalAlignment = xlLeft
        .Borders(xlEdgeBottom).LineStyle = xlContinuous
        .Value = "PLT12P60120"
    End With
    
    With ActiveSheet.Range(Cells(counter + 9, 3), Cells(counter + 9, 3))
        .HorizontalAlignment = xlLeft
        .Borders(xlEdgeBottom).LineStyle = xlContinuous
        .Value = "1/2 A36 60x120"
    End With
    
      With ActiveSheet.Range(Cells(counter + 9, 4), Cells(counter + 9, 4))
        .HorizontalAlignment = xlCenter
        .Borders(xlEdgeBottom).LineStyle = xlContinuous
        .Value = Ceiling((area5 / 7200))
    End With
    
      With ActiveSheet.Range(Cells(counter + 9, 5), Cells(counter + 9, 5))
        .HorizontalAlignment = xlCenter
        .Borders(xlEdgeBottom).LineStyle = xlContinuous
        .Value = Ceiling(area5)
    End With
    
    With ActiveSheet.Range(Cells(counter + 10, 2), Cells(counter + 10, 2))
        .HorizontalAlignment = xlLeft
        .Borders(xlEdgeBottom).LineStyle = xlContinuous
        .Value = "PLT58P60120"
    End With
    
    With ActiveSheet.Range(Cells(counter + 10, 3), Cells(counter + 10, 3))
        .HorizontalAlignment = xlLeft
        .Borders(xlEdgeBottom).LineStyle = xlContinuous
        .Value = "5/8 A36 60x120"
    End With
    
      With ActiveSheet.Range(Cells(counter + 10, 4), Cells(counter + 10, 4))
        .HorizontalAlignment = xlCenter
        .Borders(xlEdgeBottom).LineStyle = xlContinuous
        .Value = Ceiling((area625 / 7200))
    End With
    
      With ActiveSheet.Range(Cells(counter + 10, 5), Cells(counter + 10, 5))
        .HorizontalAlignment = xlCenter
        .Borders(xlEdgeBottom).LineStyle = xlContinuous
        .Value = Ceiling(area625)
    End With
    
    With ActiveSheet.Range(Cells(counter + 11, 2), Cells(counter + 11, 2))
        .HorizontalAlignment = xlLeft
        .Borders(xlEdgeBottom).LineStyle = xlContinuous
        .Value = "PLT34P4896"
    End With
    
    With ActiveSheet.Range(Cells(counter + 11, 3), Cells(counter + 11, 3))
        .HorizontalAlignment = xlLeft
        .Borders(xlEdgeBottom).LineStyle = xlContinuous
        .Value = "3/4 A36 48 x96"
    End With
    
      With ActiveSheet.Range(Cells(counter + 11, 4), Cells(counter + 11, 4))
        .HorizontalAlignment = xlCenter
        .Borders(xlEdgeBottom).LineStyle = xlContinuous
        .Value = Ceiling((area75 / 4608))
    End With
    
      With ActiveSheet.Range(Cells(counter + 11, 5), Cells(counter + 11, 5))
        .HorizontalAlignment = xlCenter
        .Borders(xlEdgeBottom).LineStyle = xlContinuous
        .Value = Ceiling(area75)
    End With
    
     With ActiveSheet.Range(Cells(counter + 12, 2), Cells(counter + 12, 2))
        .HorizontalAlignment = xlLeft
        .Borders(xlEdgeBottom).LineStyle = xlContinuous
        .Value = "PLT78P4896"
    End With
    
    With ActiveSheet.Range(Cells(counter + 12, 3), Cells(counter + 12, 3))
        .HorizontalAlignment = xlLeft
        .Borders(xlEdgeBottom).LineStyle = xlContinuous
        .Value = "7/8 A36 48 x96"
    End With
    
      With ActiveSheet.Range(Cells(counter + 12, 4), Cells(counter + 12, 4))
        .HorizontalAlignment = xlCenter
        .Borders(xlEdgeBottom).LineStyle = xlContinuous
        .Value = Ceiling((area875 / 4608))
    End With
    
      With ActiveSheet.Range(Cells(counter + 12, 5), Cells(counter + 12, 5))
        .HorizontalAlignment = xlCenter
        .Borders(xlEdgeBottom).LineStyle = xlContinuous
        .Value = Ceiling(area875)
    End With
    
    With ActiveSheet.Range(Cells(counter + 13, 2), Cells(counter + 13, 2))
        .HorizontalAlignment = xlLeft
        .Borders(xlEdgeBottom).LineStyle = xlContinuous
        .Value = "PLT1P4896"
    End With
    
    With ActiveSheet.Range(Cells(counter + 13, 3), Cells(counter + 13, 3))
        .HorizontalAlignment = xlLeft
        .Borders(xlEdgeBottom).LineStyle = xlContinuous
        .Value = "1 Inch A36 48 x96"
    End With
    
      With ActiveSheet.Range(Cells(counter + 13, 4), Cells(counter + 13, 4))
        .HorizontalAlignment = xlCenter
        .Borders(xlEdgeBottom).LineStyle = xlContinuous
        .Value = Ceiling((area1 / 4608))
    End With
    
      With ActiveSheet.Range(Cells(counter + 13, 5), Cells(counter + 13, 5))
        .HorizontalAlignment = xlCenter
        .Borders(xlEdgeBottom).LineStyle = xlContinuous
        .Value = Ceiling(area1)
    End With
    
    
    
    'Combi Rope Used
    counter = 29
    
    Select Case combiRopeColor
    Case "Red"
        With ActiveSheet.Range(Cells(counter, 1), Cells(counter, 6))
               .Interior.ColorIndex = 3
                .Font.Color = vbWhite
        End With
        
     Case "Blue"
        With ActiveSheet.Range(Cells(counter, 1), Cells(counter, 6))
               .Interior.ColorIndex = 5
                .Font.Color = vbWhite
        End With
        
        Case "Green"
        With ActiveSheet.Range(Cells(counter, 1), Cells(counter, 6))
               .Interior.ColorIndex = 10
                .Font.Color = vbWhite
        End With
        
        Case "Tan"
        With ActiveSheet.Range(Cells(counter, 1), Cells(counter, 6))
               .Interior.ColorIndex = 40
                .Font.Color = vbBlack
        End With
        
        Case Else
        
        With ActiveSheet.Range(Cells(counter, 1), Cells(counter, 6))
               .Interior.ColorIndex = 1
                .Font.Color = vbWhite
        End With
        
    End Select
    
    With ActiveSheet.Range(Cells(counter, 1), Cells(counter, 6))
        .Merge
         .HorizontalAlignment = xlCenter
        .Font.Bold = True
        .Borders(xlEdgeTop).LineStyle = xlContinuous
        .Borders(xlEdgeBottom).LineStyle = xlContinuous
        .Value = "Combi Rope Used"
    End With
    
      With ActiveSheet.Range(Cells(counter + 1, 2), Cells(counter + 1, 2))
        .HorizontalAlignment = xlLeft
        .Font.Bold = True
        .Borders(xlEdgeBottom).LineStyle = xlContinuous
        .Value = "Part Number"
    End With
    
    With ActiveSheet.Range(Cells(counter + 1, 3), Cells(counter + 1, 4))
        .HorizontalAlignment = xlCenter
        .Merge
        .Font.Bold = True
        .Borders(xlEdgeBottom).LineStyle = xlContinuous
        .Value = "Color"
    End With
    
      With ActiveSheet.Range(Cells(counter + 1, 5), Cells(counter + 1, 5))
        .HorizontalAlignment = xlCenter
        .Font.Bold = True
        .Borders(xlEdgeBottom).LineStyle = xlContinuous
        .Value = "Feet"
    End With
    
     With ActiveSheet.Range(Cells(counter + 2, 2), Cells(counter + 2, 2))
        .HorizontalAlignment = xlLeft
        .Borders(xlEdgeBottom).LineStyle = xlContinuous
        .Value = "150120" + Left(combiRopeColor, 1)
    End With
    
    With ActiveSheet.Range(Cells(counter + 2, 3), Cells(counter + 2, 4))
        .HorizontalAlignment = xlLeft
      .Merge
        .Borders(xlEdgeBottom).LineStyle = xlContinuous
        .Value = combiRopeColor
    End With
    
      With ActiveSheet.Range(Cells(counter + 2, 5), Cells(counter + 2, 5))
        .HorizontalAlignment = xlCenter
        .Borders(xlEdgeBottom).LineStyle = xlContinuous
        .Value = Ceiling(combiRope)
    End With
    
    counter = 34
    
    With ActiveSheet.Range(Cells(counter, 1), Cells(counter, 6))
        .Merge
         .HorizontalAlignment = xlCenter
        .Font.Bold = True
        .Interior.ColorIndex = 1
        .Font.Color = vbWhite
         .Borders(xlEdgeTop).LineStyle = xlContinuous
        .Borders(xlEdgeBottom).LineStyle = xlContinuous
        .Value = "Track Raw Stock Used"
    End With
    
      With ActiveSheet.Range(Cells(counter + 1, 2), Cells(counter + 1, 2))
        .HorizontalAlignment = xlCenter
              .Font.Bold = True
        .Borders(xlEdgeBottom).LineStyle = xlContinuous
        .Value = "Part Number"
    End With
    
     With ActiveSheet.Range(Cells(counter + 1, 3), Cells(counter + 1, 4))
        .Merge
        .HorizontalAlignment = xlCenter
              .Font.Bold = True
        .Borders(xlEdgeBottom).LineStyle = xlContinuous
        .Value = "Description"
    End With
    
    With ActiveSheet.Range(Cells(counter + 1, 5), Cells(counter + 1, 5))
        .HorizontalAlignment = xlCenter
              .Font.Bold = True
        .Borders(xlEdgeBottom).LineStyle = xlContinuous
        .Value = "Units"
    End With
       
    
     With ActiveSheet.Range(Cells(counter + 2, 2), Cells(counter + 2, 2))
        .HorizontalAlignment = xlLeft
          .Borders(xlEdgeBottom).LineStyle = xlContinuous
        .Value = "TYP15326"
    End With
    
    With ActiveSheet.Range(Cells(counter + 2, 3), Cells(counter + 2, 4))
        .HorizontalAlignment = xlLeft
          .Borders(xlEdgeBottom).LineStyle = xlContinuous
        .Merge
        .Value = "HSS3x3x0.25"
    End With
    
    With ActiveSheet.Range(Cells(counter + 2, 5), Cells(counter + 2, 5))
        .HorizontalAlignment = xlCenter
          .Borders(xlEdgeBottom).LineStyle = xlContinuous
        .Value = Application.RoundUp(rawStock, 0)
    End With
    
    counter = 39
    
      With ActiveSheet.Range(Cells(counter, 1), Cells(counter, 6))
        .Merge
         .HorizontalAlignment = xlCenter
        .Font.Bold = True
        .Interior.ColorIndex = 1
        .Font.Color = vbWhite
         .Borders(xlEdgeTop).LineStyle = xlContinuous
        .Borders(xlEdgeBottom).LineStyle = xlContinuous
        .Value = "Misc Inventoried Items"
    End With
    
    
      With ActiveSheet.Range(Cells(counter + 1, 2), Cells(counter + 1, 2))
        .HorizontalAlignment = xlCenter
         .Font.Bold = True
        .Borders(xlEdgeBottom).LineStyle = xlContinuous
        .Value = "Part Number"
    End With
    
     With ActiveSheet.Range(Cells(counter + 1, 3), Cells(counter + 1, 4))
        .HorizontalAlignment = xlCenter
         .Font.Bold = True
        .Borders(xlEdgeBottom).LineStyle = xlContinuous
        .Merge
        .Value = "Description"
    End With
    
    With ActiveSheet.Range(Cells(counter + 1, 5), Cells(counter + 1, 5))
        .HorizontalAlignment = xlCenter
         .Font.Bold = True
        .Borders(xlEdgeBottom).LineStyle = xlContinuous
        .Value = "Qty"
    End With
    
    Dim x As Integer
    x = 0
    
    counter = 39
    
    Dim miscItems() As String
    ReDim miscItems(2)
    
    'For x = 0 To UBound(miscArray)
    For x = 0 To UBound(inventoryParts)
    
    miscItems = Split(inventoryParts(x), ",")
    
     With ActiveSheet.Range(Cells(counter, 2), Cells(counter, 2))
        .HorizontalAlignment = xlLeft
         .Borders(xlEdgeBottom).LineStyle = xlContinuous
        .Value = miscItems(0)
    End With
    
      With ActiveSheet.Range(Cells(counter, 3), Cells(counter, 4))
        .HorizontalAlignment = xlLeft
         .Borders(xlEdgeBottom).LineStyle = xlContinuous
        .Merge
        .Value = miscItems(2)
    End With
      With ActiveSheet.Range(Cells(counter, 5), Cells(counter, 5))
        .HorizontalAlignment = xlCenter
         .Borders(xlEdgeBottom).LineStyle = xlContinuous
                .Value = miscItems(1)
    End With
    
    counter = counter + 1
    Next
    
    counter = counter + 2
    
    Dim preFabItems() As String
    ReDim preFabItems(2)
    
     With ActiveSheet.Range(Cells(counter, 1), Cells(counter, 6))
        .Merge
         .HorizontalAlignment = xlCenter
        .Font.Bold = True
        .Interior.ColorIndex = 1
        .Font.Color = vbWhite
         .Borders(xlEdgeTop).LineStyle = xlContinuous
        .Borders(xlEdgeBottom).LineStyle = xlContinuous
        .Value = "Pre Fab Fasteners"
    End With
    
    
      With ActiveSheet.Range(Cells(counter + 1, 2), Cells(counter + 1, 2))
        .HorizontalAlignment = xlCenter
         .Font.Bold = True
         .Borders(xlEdgeBottom).LineStyle = xlContinuous
        .Value = "Part Number"
    End With
    
     With ActiveSheet.Range(Cells(counter + 1, 3), Cells(counter + 1, 4))
        .HorizontalAlignment = xlCenter
         .Font.Bold = True
         .Borders(xlEdgeBottom).LineStyle = xlContinuous
        .Merge
        .Value = "Description"
    End With
    
    With ActiveSheet.Range(Cells(counter + 1, 5), Cells(counter + 1, 5))
        .HorizontalAlignment = xlCenter
         .Font.Bold = True
         .Borders(xlEdgeBottom).LineStyle = xlContinuous
        .Value = "Qty"
    End With
    
    counter = counter + 2
    
       For x = 0 To UBound(prefabFastenerArray)
    
    preFabItems = Split(prefabFastenerArray(x), ",")
    
     With ActiveSheet.Range(Cells(counter, 2), Cells(counter, 2))
        .HorizontalAlignment = xlLeft
         .Borders(xlEdgeBottom).LineStyle = xlContinuous
        .Value = preFabItems(0)
    End With
    
      With ActiveSheet.Range(Cells(counter, 3), Cells(counter, 4))
        .HorizontalAlignment = xlLeft
         .Borders(xlEdgeBottom).LineStyle = xlContinuous
        .Merge
        .Value = preFabItems(2)
    End With
      With ActiveSheet.Range(Cells(counter, 5), Cells(counter, 5))
        .HorizontalAlignment = xlCenter
         .Borders(xlEdgeBottom).LineStyle = xlContinuous
                .Value = preFabItems(1)
    End With
    
    counter = counter + 1
    Next
    
   'increment the counter to start a new section
    counter = counter + 2
    
    Dim safetyItems() As String
    ReDim safetyItems(2)
    
     With ActiveSheet.Range(Cells(counter, 1), Cells(counter, 6))
        .Merge
         .HorizontalAlignment = xlCenter
        .Font.Bold = True
        .Interior.ColorIndex = 1
        .Font.Color = vbWhite
         .Borders(xlEdgeTop).LineStyle = xlContinuous
        .Borders(xlEdgeBottom).LineStyle = xlContinuous
        .Value = "Safety Items"
    End With
    
    
      With ActiveSheet.Range(Cells(counter + 1, 2), Cells(counter + 1, 2))
        .HorizontalAlignment = xlCenter
         .Font.Bold = True
         .Borders(xlEdgeBottom).LineStyle = xlContinuous
        .Value = "Part Number"
    End With
    
     With ActiveSheet.Range(Cells(counter + 1, 3), Cells(counter + 1, 4))
        .HorizontalAlignment = xlCenter
         .Font.Bold = True
         .Borders(xlEdgeBottom).LineStyle = xlContinuous
        .Merge
        .Value = "Description"
    End With
    
    With ActiveSheet.Range(Cells(counter + 1, 5), Cells(counter + 1, 5))
        .HorizontalAlignment = xlCenter
         .Font.Bold = True
         .Borders(xlEdgeBottom).LineStyle = xlContinuous
        .Value = "Qty"
    End With
    counter = counter + 2
       For x = 0 To UBound(safetyArray)
    
    safetyItems = Split(safetyArray(x), ",")
    
     With ActiveSheet.Range(Cells(counter, 2), Cells(counter, 2))
        .HorizontalAlignment = xlLeft
         .Borders(xlEdgeBottom).LineStyle = xlContinuous
        .Value = safetyItems(0)
    End With
    
      With ActiveSheet.Range(Cells(counter, 3), Cells(counter, 4))
        .HorizontalAlignment = xlLeft
         .Borders(xlEdgeBottom).LineStyle = xlContinuous
        .Merge
        .Value = safetyItems(2)
    End With
      With ActiveSheet.Range(Cells(counter, 5), Cells(counter, 5))
        .HorizontalAlignment = xlCenter
         .Borders(xlEdgeBottom).LineStyle = xlContinuous
                .Value = safetyItems(1)
    End With
    
    counter = counter + 1
    Next

    reportWorkbook.Worksheets().Add().Name = "All Misc Items"
    Worksheets("All Misc Items").Move after:=Worksheets("Inventory Report")
     Worksheets("Sheet1").Delete
    
     ActiveSheet.Range(Cells(1, 1), Cells(1, 1)).ColumnWidth = 2 'spacer column
     ActiveSheet.Range(Cells(1, 2), Cells(1, 2)).ColumnWidth = 20 'Item
     ActiveSheet.Range(Cells(1, 3), Cells(1, 3)).ColumnWidth = 30 'Description
     ActiveSheet.Range(Cells(1, 4), Cells(1, 4)).ColumnWidth = 30 'Qty
     ActiveSheet.Range(Cells(1, 5), Cells(1, 5)).ColumnWidth = 12 'Qty
     ActiveSheet.Range(Cells(1, 6), Cells(1, 6)).ColumnWidth = 2 'Qty
   
   
   counter = 2
   
      With ActiveSheet.Range(Cells(counter, 1), Cells(counter, 6))
        .Merge
         .HorizontalAlignment = xlCenter
        .Font.Bold = True
        .Interior.ColorIndex = 1
        .Font.Color = vbWhite
         .Borders(xlEdgeTop).LineStyle = xlContinuous
        .Borders(xlEdgeBottom).LineStyle = xlContinuous
        .Value = "All Misc Items"
    End With
    
    
      With ActiveSheet.Range(Cells(counter + 1, 2), Cells(counter + 1, 2))
        .HorizontalAlignment = xlCenter
         .Font.Bold = True
        .Borders(xlEdgeBottom).LineStyle = xlContinuous
        .Value = "Part Number"
    End With
    
     With ActiveSheet.Range(Cells(counter + 1, 3), Cells(counter + 1, 4))
        .HorizontalAlignment = xlCenter
         .Font.Bold = True
        .Borders(xlEdgeBottom).LineStyle = xlContinuous
        .Merge
        .Value = "Description"
    End With
    
    With ActiveSheet.Range(Cells(counter + 1, 5), Cells(counter + 1, 5))
        .HorizontalAlignment = xlCenter
         .Font.Bold = True
        .Borders(xlEdgeBottom).LineStyle = xlContinuous
        .Value = "Qty"
    End With
    
    Dim z As Integer
    z = 0
    
   
   counter = 4
    Dim allItems() As String
    ReDim allItems(2)
    
   For z = 0 To UBound(miscArray)
    
    allItems = Split(miscArray(z), ",")
    
     With ActiveSheet.Range(Cells(counter, 2), Cells(counter, 2))
        .HorizontalAlignment = xlLeft
         .Borders(xlEdgeBottom).LineStyle = xlContinuous
        .Value = allItems(0)
    End With
    
      With ActiveSheet.Range(Cells(counter, 3), Cells(counter, 4))
        .HorizontalAlignment = xlLeft
         .Borders(xlEdgeBottom).LineStyle = xlContinuous
        .Merge
        .Value = allItems(2)
    End With
      With ActiveSheet.Range(Cells(counter, 5), Cells(counter, 5))
        .HorizontalAlignment = xlCenter
         .Borders(xlEdgeBottom).LineStyle = xlContinuous
                .Value = allItems(1)
    End With
    
    counter = counter + 1
    Next
    

End Sub
Private Sub SquareInches(row As Integer, quantity As Double, section As String, length As Double)
'first remove the PLT
'2nd take everything to the left of the X

Dim thickness As Double
Dim width As Double
Dim area As Double
Dim first As String
Dim second As String
Dim third As String
Dim x As Integer
first = Right(section, Len(section) - 3)
second = Right(first, Len(first) - InStr(first, "X"))
thickness = Left(first, InStr(first, "X") - 1)
width = CDbl(Right(second, Len(second) - InStr(second, "X")))
area = CLng((length * width) * quantity)

Select Case thickness
    Case 0.07
        area07 = area07 + area
    Case 0.1196
        area1196 = area1196 + area
    Case 0.12
        area125 = area125 + area
    Case 0.125
        area125 = area125 + area
   Case 0.1875
        area1875 = area1875 + area
    Case 0.25
        area25 = area25 + area
    Case 0.375
        area375 = area375 + area
    Case 0.5
        area5 = area5 + area
    Case 0.625
        area625 = area625 + area
    Case 0.75
        area75 = area75 + area
    Case 0.875
        area875 = area875 + area
    Case 1
        area1 = area1 + area
    Case Else
        areau = areau + area
End Select

End Sub


Private Sub sBuildItemArray()

'need to change so not hard coded
  Dim categoryColumn As Integer
  Dim itemColumn As Integer
    itemColumn = 1
    categoryColumn = 5
  Dim endItems As Integer
  endItems = [A65536].End(xlUp).row
  Dim i As Integer
  ReDim itemNumbers(0)
    For i = 2 To endItems
        'check for category in
        If ActiveSheet.Cells(i, categoryColumn) = "Inventory Part" Then
             itemNumbers(UBound(itemNumbers)) = ActiveSheet.Cells(i, itemColumn)
            ReDim Preserve itemNumbers(UBound(itemNumbers) + 1)
        End If
    Next
    If UBound(itemNumbers) > 1 Then
        ReDim Preserve itemNumbers(UBound(itemNumbers) - 1)
    End If


End Sub

Private Sub PartsArray()

'============ get all of the items on the parts list and create a multi dimensional array ==========
Dim endParts As Integer
endParts = [A65536].End(xlUp).row
parts = Range("a2:p" & endParts).Value
    
End Sub

Public Function Ceiling(RoundValue) As Double
    Dim TheValue As Double
    TheValue = RoundValue - Int(RoundValue)
 
    If TheValue = 0 Then
        Ceiling = RoundValue
    ElseIf TheValue <= 0.25 Then
        Ceiling = Int(RoundValue) + 0.25
    ElseIf TheValue > 0.25 And TheValue <= 0.5 Then
        Ceiling = Int(RoundValue) + 0.5
    ElseIf TheValue > 0.5 And TheValue <= 0.75 Then
        Ceiling = Int(RoundValue) + 0.75
    Else
        Ceiling = Int(RoundValue) + 1
    End If
     
End Function
Private Sub matchInventoryParts()

Dim i As Integer
Dim t As Integer

ReDim inventoryParts(0)

For i = 0 To UBound(miscArray)

Dim pos As Integer
pos = InStr(miscArray(i), ",")

    For t = 0 To UBound(itemNumbers)
        If (Left(miscArray(i), 6) = Left(itemNumbers(t), 6)) Then
        
      inventoryParts(UBound(inventoryParts)) = miscArray(i)
       ReDim Preserve inventoryParts(UBound(inventoryParts) + 1)
        End If
    Next
Next

If UBound(inventoryParts) > 1 Then
    ReDim Preserve inventoryParts(UBound(inventoryParts) - 1)
End If

End Sub



