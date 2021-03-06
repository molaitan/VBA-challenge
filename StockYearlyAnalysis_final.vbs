Attribute VB_Name = "Module1"
Sub StockYearlyAnalysis_final()

For Each ws In Worksheets

'Set an initial variable for holding the ticker name
Dim Ticker_Name As String

'Set an intial variable for the opening and closing price
Dim Opening_Price As Double
Dim Closing_Price As Double

'Set an initial variable for the yearly and percent change
Dim Yearly_Change As Double
Dim Percent_Change As Variant

'Set an initial variable for counter to find first row to find opening price
Dim Counter As Double
Counter = 0

'Set an inital variable for holding the total volume per ticker
Dim Total_Volume As Double
Total_Volume = 0

'Keep track of the location of each ticker in table
Dim Summary_Table_Row As Long
Summary_Table_Row = 2

' Determine the Last Row
LastRow = ws.Cells(Rows.Count, 1).End(xlUp).Row
'MsgBox ("This is the last row #: " & LastRow)

'Loop through all the stock data
Dim i As Long
For i = 2 To LastRow
       
    'Check if we are within same ticker, if not...
    If ws.Cells(i + 1, 1).Value <> ws.Cells(i, 1).Value Then
    
        'Set the Ticker name
        Ticker_Name = ws.Cells(i, 1).Value
        
        'Add to the total volume amount
        Total_Volume = Total_Volume + ws.Cells(i, 7).Value
    
        Closing_Price = ws.Cells(i, 6).Value
        'MsgBox ("This the closing price:  " & Closing_Price)
        
        If Opening_Price = 0 Then
            Yearly_Change = 0
            Percent_Change = 0
        Else
        
        'Calculate the yearly change for that ticker
            Yearly_Change = Closing_Price - Opening_Price
        
        'Calculate the percent change for that ticker
            Percent_Change = (Yearly_Change / Opening_Price)
        'MsgBox ("This is the percent change: " & Percent_Change)
        
        End If
    
        'Print the ticker name in table
        ws.Range("I" & Summary_Table_Row).Value = Ticker_Name
        
        'Print the yearly change
        ws.Range("J" & Summary_Table_Row).Value = Yearly_Change
        
            'Format cell color of Yearly_Change
            If ws.Range("J" & Summary_Table_Row).Value > 0 Then
            ws.Range("J" & Summary_Table_Row).Interior.ColorIndex = 4
            Else: ws.Range("J" & Summary_Table_Row).Interior.ColorIndex = 3
            End If
            
        'Print percent change
        ws.Range("K" & Summary_Table_Row).Value = Percent_Change
                'Format cell decimal placing of Percent_Change
                ws.Range("K" & Summary_Table_Row).NumberFormat = "0.00%"
                
        'Print total volume
        ws.Range("L" & Summary_Table_Row).Value = Total_Volume
        
        ' Add one to the summary table row
       Summary_Table_Row = Summary_Table_Row + 1
       
       ' Reset the total volume
        Total_Volume = 0
        
        'Reset the counter
        Counter = 0
        
    ' If the cell immediately following a row is the same ticker...
    Else
    
       Counter = Counter + 1
       'MsgBox ("This is count # " & Counter)
       
      ' Add to the Total Volume
      Total_Volume = Total_Volume + ws.Cells(i, 7).Value

    End If

If Counter = 1 Then
Opening_Price = ws.Cells(i, 3).Value
 'Range("J" & Summary_Table_Row).Value = Cells(i, 3).Value
 'MsgBox ("This is the value for open at counter=1  " & Cells(i, 3).Value)
  
End If
  
  Next i
  
' Add Headers for Results Table
ws.Range("I1").Value = "Ticker"
ws.Range("J1").Value = "Yearly Change"
ws.Range("K1").Value = "Percent Change"
ws.Range("L1").Value = "Total Stock Volume"

Next ws

End Sub

