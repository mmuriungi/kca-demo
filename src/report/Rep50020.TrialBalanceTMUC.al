report 50020 "Trial BalanceTMUC"
{
    // This report is copied from 10011 GL - Fin Stm. Even though it does not and
    // cannot use the Percent To Total feature, nevertheless for maintainability and
    // ease of conversion, the 4 Percent To Total columns are still within the array,
    // even though the user can NEVER select them. These are columns 2, 4, 6 & 8.
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/Trial Balance.rdl';

    Caption = 'Trial Balance2017';

    dataset
    {
        dataitem(GLAccounts; "G/L Account")
        {
            DataItemTableView = SORTING("No.");
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.", "Account Type", "Date Filters", "Date Filter", "Global Dimension 1 Filter", "Global Dimension 2 Filter", "Budget Filter";
            column(TodayFormatted; FORMAT(TODAY, 0, 4))
            {
            }
            column(Time; TIME)
            {
            }
            column(CompanyInfoName; Name)
            {
            }
            column(PeriodText; PeriodText)
            {
            }
            column(PrintToExcel; PrintToExcel)
            {
            }
            column(PageHeaderCondition; ((NOT PrintToExcel) AND ((LineType = LineType::"9-Point") OR (LineType = LineType::"9-Point Rounded"))))
            {
            }
            column(UseAddRptCurr; UseAddRptCurr)
            {
            }
            column(PageGroupNo; PageGroupNo)
            {
            }
            column(GLAccountFilter; GLAccountFilter)
            {
            }
            column(NoofBlankLines_GLAccount; "No. of Blank Lines")
            {
            }
            column(SubTitle; SubTitle)
            {
            }
            column(TblCaptionGLAccountFilter; TABLECAPTION + ': ' + GLAccountFilter)
            {
            }
            column(ColumnHead1; ColumnHead[1])
            {
            }
            column(ColumnHead2; ColumnHead[2])
            {
            }
            column(ConditionGLAccountHeader6; ((LineType = LineType::"9-Point") AND NOT PrintToExcel))
            {
            }
            column(ColumnHead3; ColumnHead[3])
            {
            }
            column(ConditionGLAccountHeader7; ((LineType = LineType::"9-Point Rounded") AND NOT PrintToExcel))
            {
            }
            column(ColumnHead4; ColumnHead[4])
            {
            }
            column(ConditionGLAccountHeader8; ((LineType = LineType::"8-Point") AND NOT PrintToExcel))
            {
            }
            column(ConditionGLAccountHeader9; ((LineType = LineType::"8-Point Rounded") AND NOT PrintToExcel))
            {
            }
            column(ColumnHead5; ColumnHead[5])
            {
            }
            column(ColumnHead6; ColumnHead[6])
            {
            }
            column(ConditionGLAccountHeader10; ((LineType = LineType::"7-Point") AND NOT PrintToExcel))
            {
            }
            column(ColumnHead7; ColumnHead[7])
            {
            }
            column(ColumnHead8; ColumnHead[8])
            {
            }
            column(ConditionGLAccountHeader11; ((LineType = LineType::"7-Point Rounded") AND NOT PrintToExcel))
            {
            }
            column(No_GLAccount; "No.")
            {
            }
            column(TrialBalanceCaption; TrialBalanceCaptionLbl)
            {
            }
            column(PageCaption; PageCaptionLbl)
            {
            }
            column(NoCaption_GLAccount; FIELDCAPTION("No."))
            {
            }
            column(NameCaption; NameCaptionLbl)
            {
            }
            column(Debit; "Debit Amount")
            {
            }
            column(Credit; "Credit Amount")
            {
            }
            dataitem(BlankLineCounter; 2000000026)
            {
                DataItemTableView = SORTING(Number);

                trigger OnPreDataItem()
                begin
                    SETRANGE(Number, 1, GLAccount."No. of Blank Lines");
                end;
            }
            dataitem(DataItem5444; 2000000026)
            {
                DataItemTableView = SORTING(Number)
                                     WHERE(Number = CONST(1));
                column(DescriptionLine1; DescriptionLine1)
                {
                }
                column(IntegerBody1Condition; (((LineType = LineType::"9-Point") OR (LineType = LineType::"9-Point Rounded")) AND (DescriptionLine1 <> '') AND NOT PrintToExcel))
                {
                }
                column(DescriptionLine2; DescriptionLine2)
                {
                }
                column(GLAccountNo; GLAccount."No.")
                {
                }
                column(IntegerBody2Condition; (((LineType = LineType::"9-Point") OR (LineType = LineType::"9-Point Rounded")) AND (GLAccount."Account Type" <> GLAccount."Account Type"::Posting) AND (GLAccount.Totaling = '') AND NOT PrintToExcel))
                {
                }
                column(IntegerBody3Condition; (((LineType = LineType::"8-Point") OR (LineType = LineType::"8-Point Rounded")) AND (DescriptionLine1 <> '') AND NOT PrintToExcel))
                {
                }
                column(IntegerBody4Condition; (((LineType = LineType::"8-Point") OR (LineType = LineType::"8-Point Rounded")) AND (GLAccount."Account Type" <> GLAccount."Account Type"::Posting) AND (GLAccount.Totaling = '') AND NOT PrintToExcel))
                {
                }
                column(IntegerBody5Condition; (((LineType = LineType::"7-Point") OR (LineType = LineType::"7-Point Rounded")) AND (DescriptionLine1 <> '') AND NOT PrintToExcel))
                {
                }
                column(IntegerBody6Condition; (((LineType = LineType::"7-Point") OR (LineType = LineType::"7-Point Rounded")) AND (GLAccount."Account Type" <> GLAccount."Account Type"::Posting) AND (GLAccount.Totaling = '') AND NOT PrintToExcel))
                {
                }
                column(PrintAmt1; PrintAmount[1])
                {
                }
                column(PrintAmt2; PrintAmount[2])
                {
                }
                column(IntegerBody7Condition; ((LineType = LineType::"9-Point") AND NumbersToPrint AND NOT PrintToExcel))
                {
                }
                column(PrintAmt3; PrintAmount[3])
                {
                }
                column(IntegerBody8Condition; ((LineType = LineType::"9-Point Rounded") AND NumbersToPrint AND NOT PrintToExcel))
                {
                }
                column(PrintAmt4; PrintAmount[4])
                {
                }
                column(IntegerBody9Condition; ((LineType = LineType::"8-Point") AND NumbersToPrint AND NOT PrintToExcel))
                {
                }
                column(IntegerBody10Condition; ((LineType = LineType::"8-Point Rounded") AND NumbersToPrint AND NOT PrintToExcel))
                {
                }
                column(PrintAmt5; PrintAmount[5])
                {
                }
                column(PrintAmt6; PrintAmount[6])
                {
                }
                column(IntegerBody11Condition; ((LineType = LineType::"7-Point") AND NumbersToPrint AND NOT PrintToExcel))
                {
                }
                column(PrintAmt7; PrintAmount[7])
                {
                }
                column(PrintAmt8; PrintAmount[8])
                {
                }
                column(IntegerBody12Condition; ((LineType = LineType::"7-Point Rounded") AND NumbersToPrint AND NOT PrintToExcel))
                {
                }

                trigger OnAfterGetRecord()
                begin
                    IF PrintToExcel THEN
                        MakeExcelDataBody;
                end;

                trigger OnPostDataItem()
                begin
                    IF GLAccount."New Page" AND NOT PrintToExcel THEN
                        PageGroupNo := PageGroupNo + 1;
                end;
            }

            trigger OnAfterGetRecord()
            begin
                CLEAR(DescriptionLine2);
                CLEAR(DescriptionLine1);
                CLEAR(WorkAmount);
                IF ("Account Type" = "Account Type"::Posting) OR
                   (Totaling <> '')
                THEN BEGIN
                    SETRANGE("Date Filters", FromDate, ToDate);
                    IF UseAddRptCurr THEN BEGIN
                        CALCFIELDS("Additional-Currency Net Change", "Add.-Currency Balance at Date");
                        WorkAmount[1] := "Additional-Currency Net Change";
                        WorkAmount[7] := "Add.-Currency Balance at Date";
                    END ELSE BEGIN
                        CALCFIELDS("Net Change", "Balance at Date");
                        WorkAmount[1] := "Net Change";
                        WorkAmount[7] := "Balance at Date";
                    END;
                    IF Show = Show::Budget THEN BEGIN
                        CALCFIELDS("Budgeted Amount", "Budget at Date");
                        WorkAmount[3] := "Budgeted Amount";
                        WorkAmount[9] := "Budget at Date";
                    END ELSE BEGIN
                        SETRANGE("Date Filters", PriorFromDate, PriorToDate);
                        IF UseAddRptCurr THEN BEGIN
                            CALCFIELDS("Additional-Currency Net Change", "Add.-Currency Balance at Date");
                            WorkAmount[3] := "Additional-Currency Net Change";
                            WorkAmount[9] := "Add.-Currency Balance at Date";
                        END ELSE BEGIN
                            CALCFIELDS("Net Change", "Balance at Date");
                            WorkAmount[3] := "Net Change";
                            WorkAmount[9] := "Balance at Date";
                        END;
                    END;
                    IF ColumnFlags[5] OR ColumnFlags[6] THEN
                        WorkAmount[5] := WorkAmount[1] - WorkAmount[3];
                    IF ColumnFlags[6] AND (WorkAmount[3] <> 0.0) THEN
                        WorkAmount[6] := WorkAmount[5] / WorkAmount[3] * 100.0;
                    IF ColumnFlags[11] OR ColumnFlags[12] THEN
                        WorkAmount[11] := WorkAmount[7] - WorkAmount[9];
                    IF ColumnFlags[12] AND (WorkAmount[9] <> 0.0) THEN
                        WorkAmount[12] := WorkAmount[11] / WorkAmount[9] * 100.0;
                END;
                // Handle the description 
                DescriptionLine2 := PADSTR('', Indentation) + Name;
                ParagraphHandling.SplitPrintLine(DescriptionLine2, DescriptionLine1, MaxDescWidth, PointSize);
                // Format the numbers (if any) 
                IF NumbersToPrint THEN BEGIN
                    // format the individual numbers, first numerically 
                    FOR i := 1 TO 12 DO BEGIN
                        IF RoundTo = RoundTo::Dollars THEN
                            WorkAmount[i] := ROUND(WorkAmount[i], 1)
                        ELSE
                            IF RoundTo = RoundTo::Thousands THEN BEGIN
                                IF i MOD 2 = 0 THEN  // percents
                                    WorkAmount[i] := ROUND(WorkAmount[i], 1)
                                ELSE                 // amounts
                                    WorkAmount[i] := ROUND(WorkAmount[i] / 1000, 1);
                            END ELSE                                     // to nearest penny
                                WorkAmount[i] := ROUND(WorkAmount[i], 0.01);
                    END;
                    //now format the strings
                    FOR i := 1 TO 12 DO BEGIN
                        PrintAmount[i] := FORMAT(WorkAmount[i]);
                        IF RoundTo = RoundTo::Pennies THEN BEGIN   // add decimal places if necessary
                            j := STRPOS(PrintAmount[i], '.');
                            IF j = 0 THEN
                                PrintAmount[i] := PrintAmount[i] + '.00'
                            ELSE
                                IF j = STRLEN(PrintAmount[i]) - 1 THEN
                                    PrintAmount[i] := PrintAmount[i] + '0';
                        END;
                        IF i MOD 2 = 0 THEN    // percents
                            PrintAmount[i] := PrintAmount[i] + '%';
                    END;
                    // final trick, compress the columns so only those the user wants are seen 
                    CompressColumns(PrintAmount);
                END;

            end;

            trigger OnPreDataItem()
            begin
                IF ISEMPTY THEN
                    ERROR(MissingGLAccountErr);
            end;
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(ShowComaprison; Show)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Show Comparison';
                        OptionCaption = 'Last Year,Budget';
                        ToolTip = 'Specifies if figures either from the prior year or for the defined budget are included.';
                    }
                    group("Select Report Columns")
                    {
                        Caption = 'Select Report Columns';
                        field(ActualChange; ColumnFlags[1])
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Actual Changes';
                            ToolTip = 'Specifies that a column is added that shows the actual net change.';

                            trigger OnValidate()
                            begin
                                TestNumColumns;
                            end;
                        }
                        field(ComparisonChanges; ColumnFlags[3])
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Comparison Changes';
                            ToolTip = 'Specifies if you want to include the net changes from the selected period.';

                            trigger OnValidate()
                            begin
                                TestNumColumns;
                            end;
                        }
                        field(ColumnFlags5; ColumnFlags[5])
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Variance in Changes';
                            ToolTip = 'Specifies if you want to include a column that shows the change variance. The variance is calculated by subtracting the budget or prior year amounts over the period defined from the actual amounts.';

                            trigger OnValidate()
                            begin
                                TestNumColumns;
                            end;
                        }
                        field(ColumnFlags6; ColumnFlags[6])
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = '% Variance in Changes';
                            ToolTip = 'Specifies that a column is inserted that shows the percentage of variance in balances. The variance is calculated by dividing the variance by the actual amounts.';

                            trigger OnValidate()
                            begin
                                TestNumColumns;
                            end;
                        }
                        field(ActualBalances; ColumnFlags[7])
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Actual Balances';
                            ToolTip = 'Specifies that a column is added that shows the actual balance.';

                            trigger OnValidate()
                            begin
                                TestNumColumns;
                            end;
                        }
                        field(ComparisonBalances; ColumnFlags[9])
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Comparison Balances';
                            ToolTip = 'Specifies if you want to include the balance from the selected period.';

                            trigger OnValidate()
                            begin
                                TestNumColumns;
                            end;
                        }
                        field(ColumnFlags11; ColumnFlags[11])
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Variance in Balances';
                            ToolTip = 'Specifies if you want to include a column that shows the balance variance. The variance is calculated by subtracting the budget or prior year amounts over the period defined from the actual amounts.';

                            trigger OnValidate()
                            begin
                                TestNumColumns;
                            end;
                        }
                        field(ColumnFlags; ColumnFlags[12])
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = '% Variance in Balances';
                            ToolTip = 'Specifies that a column is inserted that shows the percentage of variance in balances. The variance is calculated by dividing the variance by the actual amounts.';

                            trigger OnValidate()
                            begin
                                TestNumColumns;
                            end;
                        }
                    }
                    field(RoundTo; RoundTo)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Round to';
                        OptionCaption = 'Pennies,Dollars,Thousands';
                        ToolTip = 'Specifies if you want the results in the report to be rounded to the nearest penny (hundredth of a unit), dollar (unit), or thousand dollars (units). The results are in US dollars, unless you use an additional reporting currency.';

                        trigger OnValidate()
                        begin
                            IF RoundTo = RoundTo::Thousands THEN
                                ThousandsRoundToOnValidate;
                            IF RoundTo = RoundTo::Dollars THEN
                                DollarsRoundToOnValidate;
                            IF RoundTo = RoundTo::Pennies THEN
                                PenniesRoundToOnValidate;
                        end;
                    }
                    field(SkipZeros; SkipZeros)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Skip Accounts with all zero Amounts';
                        MultiLine = true;
                        ToolTip = 'Specifies if you want the report to be generated with all of the accounts, including those with zero amounts. Otherwise, those accounts will be excluded.';
                    }
                    field(UseAdditionalReportingCurrency; UseAddRptCurr)
                    {
                        ApplicationArea = Suite;
                        Caption = 'Use Additional Reporting Currency';
                        MultiLine = true;
                        ToolTip = 'Specifies if you want all amounts to be printed by using the additional reporting currency. If you do not select the check box, then all amounts will be printed in US dollars.';
                    }
                    field(PrintToExcel; PrintToExcel)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Print to Excel';
                        ToolTip = 'Specifies if you want to export the data to an Excel spreadsheet for additional analysis or formatting before printing.';

                        trigger OnValidate()
                        begin
                            TestNumColumns;
                        end;
                    }
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPostReport()
    begin
        //IF PrintToExcel THEN
        //  CreateExcelbook;
    end;

    trigger OnPreReport()
    begin
        CompanyInformation.GET;
        // Set up format-dependent variables 
        CASE NumColumns OF
            0:
                ERROR(Text000);
            1, 2:
                IF RoundTo = RoundTo::Pennies THEN
                    LineType := LineType::"9-Point"
                ELSE
                    LineType := LineType::"9-Point Rounded";
            3:
                IF RoundTo = RoundTo::Pennies THEN
                    LineType := LineType::"8-Point"
                ELSE
                    LineType := LineType::"9-Point Rounded";
            4:
                IF RoundTo = RoundTo::Pennies THEN
                    LineType := LineType::"8-Point"
                ELSE
                    LineType := LineType::"8-Point Rounded";
            5, 6:
                IF RoundTo = RoundTo::Pennies THEN
                    LineType := LineType::"7-Point"
                ELSE
                    LineType := LineType::"7-Point Rounded";
            7, 8:
                IF (RoundTo = RoundTo::Pennies) AND NOT PrintToExcel THEN
                    ERROR(Text001)
                ELSE
                    LineType := LineType::"7-Point Rounded";
            ELSE
                ERROR(Text002);
        END;
        IF RoundTo = RoundTo::Pennies THEN
            ExcelAmtFormat := '#,##0.00'
        ELSE
            ExcelAmtFormat := '#,##0';

        CASE LineType OF
            LineType::"9-Point", LineType::"9-Point Rounded":
                BEGIN
                    MaxDescWidth := 67;
                    PointSize := 9;
                END;
            LineType::"8-Point", LineType::"8-Point Rounded":
                BEGIN
                    MaxDescWidth := 52;
                    PointSize := 8;
                END;
            LineType::"7-Point", LineType::"7-Point Rounded":
                BEGIN
                    MaxDescWidth := 33;
                    PointSize := 7;
                END;
            ELSE
                ERROR(Text003);
        END;
        // set up the date ranges 
        GLAccount.SecurityFiltering(SecurityFilter::Filtered);
        //GLFilter := GLAccount.GetFilters;
        PeriodText := GLAccount.GetFilter("Date Filters");

        FromDate := GLAccount.GetRangeMin("Date Filter");
        ToDate := GLAccount.GetRangeMax("Date Filter");
        PriorFromDate := CALCDATE('<-1Y>', FromDate + 1) - 1;
        PriorToDate := CALCDATE('<-1Y>', ToDate + 1) - 1;
        GLAccount.SETRANGE("Date Filter");       // since it is in the title, it does
        GLAccountFilter := GLAccount.GETFILTERS; // not have to be in the filter string
                                                 // set up header texts
                                                 //  Note: Since these texts are built up piece by piece, it would do no good to
                                                 //        attempt to translate the individual pieces. Therefore, these texts have
                                                 //        not been placed into text constants.

        CLEAR(PeriodText);
        CLEAR(ColumnHead);
        // Period Headings 
        IF ColumnFlags[7] THEN BEGIN                              // YTD
            PeriodText := 'As of ' + FORMAT(ToDate, 0, 4);
            IF ColumnFlags[9] THEN BEGIN
                IF Show = Show::Budget THEN                           // Budget
                    PeriodText := 'Actual vs Budget a' + DELSTR(PeriodText, 1, 1)
                //ELSE                                                  // Prior YTD
                //   PeriodText := PeriodText + ' and ' + FORMAT(DATE2DMY(PriorToDate, 3));
            END;
        END ELSE
            IF ColumnFlags[9] THEN BEGIN
                IF Show = Show::Budget THEN                             // Budget
                    PeriodText := 'Budget as of ' + FORMAT(ToDate, 0, 4)
                ELSE                                                    // Prior YTD
                    PeriodText := 'As of ' + FORMAT(PriorToDate, 0, 4);
            END ELSE
                IF ColumnFlags[1] THEN BEGIN                     // PTD
                    PeriodText := 'Changes ';
                    IF ColumnFlags[3] AND (Show = Show::Budget) THEN        // Budget
                        PeriodText := PeriodText + 'and Budgeted Changes ';
                    PeriodText := PeriodText + 'from '
                      + FORMAT(FromDate, 0, 4)
                      + ' to '
                      + FORMAT(ToDate, 0, 4);
                    IF ColumnFlags[3] AND (Show = Show::"Last Year") THEN   // Prior PTD
                        PeriodText := PeriodText + ' and from '
                          + FORMAT(PriorFromDate, 0, 4)
                          + ' to '
                          + FORMAT(PriorToDate, 0, 4);
                END ELSE
                    IF ColumnFlags[3] THEN BEGIN                     // PTD
                        IF Show = Show::Budget THEN                           // Budget
                            PeriodText := 'Budgeted '
                        ELSE                                                    // Prior PTD
                            PeriodText := '';
                        PeriodText := PeriodText + 'Changes from ';
                        IF Show = Show::Budget THEN                           // Budget
                            PeriodText := PeriodText + FORMAT(FromDate, 0, 4)
                              + ' to '
                              + FORMAT(ToDate, 0, 4)
                        ELSE                                                    // Prior PTD
                            PeriodText := PeriodText + FORMAT(PriorFromDate, 0, 4)
                              + ' to '
                              + FORMAT(PriorToDate, 0, 4);
                    END;
        IF UseAddRptCurr THEN BEGIN
            GLSetup.GET;
            Currency.GET(GLSetup."Additional Reporting Currency");
            SubTitle := STRSUBSTNO(Text004, Currency.Description);
        END;

        // Column Headings 
        IF Show = Show::Budget THEN
            ColumnHead[3] := Text005
        ELSE
            ColumnHead[3] := Text006;
        ColumnHead[9] := ColumnHead[3];
        ColumnHead[5] := Text007;
        ColumnHead[6] := Text008;
        ColumnHead[11] := Text009;
        ColumnHead[12] := Text010;
        ColumnHead[1] := Text011;
        ColumnHead[7] := Text012;
        ColumnHead[3] := ColumnHead[3] + Text011;
        ColumnHead[9] := ColumnHead[9] + Text012;
        IF RoundTo = RoundTo::Thousands THEN
            FOR i := 1 TO 12 DO
                IF i MOD 2 = 1 THEN
                    ColumnHead[i] := ColumnHead[i] + Text013;
        CompressColumns(ColumnHead);
        IF PrintToExcel THEN
            MakeExcelInfo;

    end;

    var
        CompanyInformation: Record 79;
        GLAccount: record "G/L Account";
        GLSetup: Record 98;
        Currency: Record 4;
        GLFilter: Text;

        ExcelBuf: Record 370 temporary;
        ParagraphHandling: Codeunit "Paragraph Handling";
        PeriodText: Text[120];
        GLAccountFilter: Text;
        SubTitle: Text[132];
        SkipZeros: Boolean;
        UseAddRptCurr: Boolean;
        PrintToExcel: Boolean;
        Show: Option "Last Year",Budget;
        RoundTo: Option Pennies,Dollars,Thousands;
        LineType: Option "9-Point","9-Point Rounded","8-Point","8-Point Rounded","7-Point","7-Point Rounded";
        ColumnFlags: array[12] of Boolean;
        ColumnHead: array[12] of Text[50];
        PrintAmount: array[12] of Text[30];
        WorkAmount: array[12] of Decimal;
        FromDate: Date;
        ToDate: Date;
        PriorFromDate: Date;
        PriorToDate: Date;
        DescriptionLine2: Text[80];
        DescriptionLine1: Text[80];
        MaxDescWidth: Integer;
        PointSize: Integer;
        j: Integer;
        i: Integer;
        Text000: Label 'You must select at least one Report Column.';
        Text001: Label 'If you want more than 6 Report Columns you must round to Dollars or Thousands.';
        Text002: Label 'You may select a maximum of 8 Report Columns.';
        Text003: Label 'Program Bug.';
        Text004: Label 'Amounts are in %1';
        Text005: Label 'Budgeted, ';
        Text006: Label 'Last Year, ';
        Text007: Label 'Change Variance';
        Text008: Label 'Change % Variance';
        Text009: Label 'Balance Variance';
        Text010: Label 'Balance % Variance';
        Text011: Label 'Net Change';
        Text012: Label 'Balance';
        Text013: Label ' (Thousands)';
        Text101: Label 'Data';
        Text102: Label 'Trial Balance';
        Text103: Label 'Company Name';
        Text104: Label 'Report No.';
        Text105: Label 'Report Name';
        Text106: Label 'User ID';
        Text107: Label 'Date / Time';
        Text108: Label 'G/L Account Filters';
        Text109: Label 'Sub-Title';
        Text110: Label 'Amounts are in';
        Text111: Label 'our Functional Currency';
        ExcelAmtFormat: Text[30];
        PageGroupNo: Integer;
        TrialBalanceCaptionLbl: Label 'Trial Balance';
        PageCaptionLbl: Label 'Page';
        NameCaptionLbl: Label 'Name';
        MissingGLAccountErr: Label 'No G/L account exists within the specified filter.';

    procedure NumColumns() NumCol: Integer
    var
        i: Integer;
    begin
        // Counts the Number of Columns that the user selected 
        NumCol := 0;
        FOR i := 1 TO ARRAYLEN(ColumnFlags) DO
            IF ColumnFlags[i] THEN
                NumCol := NumCol + 1;
        EXIT(NumCol);

    end;

    procedure TestNumColumns()
    begin
        IF NumColumns > 8 THEN
            ERROR(Text002);
        IF (NumColumns > 6) AND (RoundTo = RoundTo::Pennies) AND NOT PrintToExcel THEN
            ERROR(Text001);
    end;

    procedure NumbersToPrint(): Boolean
    var
        i: Integer;
    begin
        // Returns whether any numbers are available to be printed this time 
        IF (GLAccount."Account Type" <> GLAccount."Account Type"::Posting) AND
           (GLAccount.Totaling = '')
        THEN
            EXIT(FALSE);
        IF (GLAccount."Account Type" = GLAccount."Account Type"::Posting) AND SkipZeros THEN BEGIN
            FOR i := 1 TO ARRAYLEN(ColumnFlags) DO
                IF (WorkAmount[i] <> 0.0) AND ColumnFlags[i] THEN
                    EXIT(TRUE);
            EXIT(FALSE);
        END;
        EXIT(TRUE);

    end;

    procedure CompressColumns(var StringArray: array[12] of Text[30])
    var
        i: Integer;
        j: Integer;
    begin
        // Moves all active columns together 
        j := 0;
        FOR i := 1 TO ARRAYLEN(ColumnFlags) DO
            IF ColumnFlags[i] THEN BEGIN
                j := j + 1;
                StringArray[j] := StringArray[i];
            END;
        FOR i := j + 1 TO ARRAYLEN(ColumnFlags) DO
            StringArray[i] := '';

    end;

    local procedure MakeExcelInfo()
    begin
        ExcelBuf.SetUseInfoSheet;
        ExcelBuf.AddInfoColumn(FORMAT(Text103), FALSE, TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn(CompanyInformation.Name, FALSE, FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(FORMAT(Text105), FALSE, TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn(FORMAT(Text102), FALSE, FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(FORMAT(Text104), FALSE, TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn(REPORT::"Trial Balance", FALSE, FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(FORMAT(Text106), FALSE, TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn(USERID, FALSE, FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(FORMAT(Text107), FALSE, TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn(TODAY, FALSE, FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Date);
        ExcelBuf.AddInfoColumn(TIME, FALSE, FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Time);
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(FORMAT(Text108), FALSE, TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn(GLAccountFilter, FALSE, FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(FORMAT(Text109), FALSE, TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn(PeriodText, FALSE, FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(FORMAT(Text110), FALSE, TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        IF UseAddRptCurr THEN
            ExcelBuf.AddInfoColumn(Currency.Description, FALSE, FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text)
        ELSE
            ExcelBuf.AddInfoColumn(FORMAT(Text111), FALSE, FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.ClearNewRow;
        MakeExcelDataHeader;
    end;

    local procedure MakeExcelDataHeader()
    var
        i: Integer;
    begin
        ExcelBuf.NewRow;
        ExcelBuf.AddColumn(GLAccount.FIELDCAPTION("No."), FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(GLAccount.FIELDCAPTION(Name), FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        FOR i := 1 TO NumColumns DO
            ExcelBuf.AddColumn(ColumnHead[i], FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
    end;

    local procedure MakeExcelDataBody()
    var
        Percentage: Decimal;
    begin
        IF NumbersToPrint OR
           ((GLAccount."Account Type" <> GLAccount."Account Type"::Posting) AND
            (GLAccount.Totaling = ''))
        THEN BEGIN
            ExcelBuf.NewRow;
            IF (GLAccount."Account Type" <> GLAccount."Account Type"::Posting) AND
               (GLAccount.Totaling = '')
            THEN BEGIN
                ExcelBuf.AddColumn(GLAccount."No.", FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                ExcelBuf.AddColumn(
                  PADSTR('', GLAccount.Indentation * 2) + GLAccount.Name, FALSE, '', TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
            END ELSE BEGIN
                ExcelBuf.AddColumn(GLAccount."No.", FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
                ExcelBuf.AddColumn(
                  PADSTR('', GLAccount.Indentation * 2) + GLAccount.Name, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
            END;
            IF NumbersToPrint THEN
                FOR i := 1 TO NumColumns DO BEGIN
                    IF STRPOS(PrintAmount[i], '%') <> 0 THEN BEGIN
                        // fix for exporting % values
                        EVALUATE(Percentage, DELCHR(PrintAmount[i], '=', '%'));
                        Percentage := Percentage / 100;
                        ExcelBuf.AddColumn(Percentage, FALSE, '', FALSE, FALSE, FALSE, ExcelAmtFormat + '%', ExcelBuf."Cell Type"::Number)
                    END ELSE
                        ExcelBuf.AddColumn(PrintAmount[i], FALSE, '', FALSE, FALSE, FALSE, ExcelAmtFormat, ExcelBuf."Cell Type"::Number);
                END;
        END;
    end;

    local procedure CreateExcelbook()
    begin
        // ExcelBuf.CreateBookAndOpenExcel('', Text101, Text102, COMPANYNAME, USERID);

        // ERROR('');
    end;

    local procedure PenniesRoundToOnValidate()
    begin
        TestNumColumns;
    end;

    local procedure DollarsRoundToOnValidate()
    begin
        TestNumColumns;
    end;

    local procedure ThousandsRoundToOnValidate()
    begin
        TestNumColumns;
    end;

}
