page 50166 "Workplan Activities - Convert"
{
    Editable = true;
    PageType = List;
    SourceTable = "Workplan Activities";
    SourceTableView = WHERE("Uploaded to Procurement Workpl" = CONST(true));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                IndentationColumn = NameIndent;
                IndentationControls = "Activity Code";
                field("Activity Code"; Rec."Activity Code")
                {
                    Caption = 'Activity Code';
                    Style = Strong;
                    StyleExpr = NameEmphasize;
                }
                field("Workplan Code"; Rec."Workplan Code")
                {
                    Style = Strong;
                    StyleExpr = NameEmphasize;
                }
                field("Activity Description"; Rec."Activity Description")
                {
                    Style = Strong;
                    StyleExpr = NameEmphasize;
                }
                field("Account Type"; Rec."Account Type")
                {
                    Style = Strong;
                    StyleExpr = NoEmphasize;

                    trigger OnValidate()
                    begin
                        UpdateControls;
                    end;
                }
                field(Type; Rec.Type)
                {
                    Caption = 'Type';
                    Style = Strong;
                    StyleExpr = NameEmphasize;
                }
                field("Expense Code"; Rec."Expense Code")
                {
                }
                field("No."; Rec."No.")
                {
                }
                field(Totaling; Rec.Totaling)
                {
                    Editable = false;
                    Style = Strong;
                    StyleExpr = NoEmphasize;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                }
                field("Amount to Transfer"; Rec."Amount to Transfer")
                {
                }
                field("Budgeted Amount"; Rec."Budgeted Amount")
                {
                }
                field("Converted to Budget"; Rec."Converted to Budget")
                {
                    Editable = false;
                }
            }
        }

    }

    actions
    {
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                Visible = false;
                action(IndentWorkPlan)
                {
                    Caption = 'Indent Workplan Activities';
                    Image = IndentChartOfAccounts;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Codeunit "Workplan Indent";
                }
                action(Convert)
                {
                    Caption = 'Convert to Workplan Budget Entry';
                    Image = InsertFromCheckJournal;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        //DW
                        IF Rec."Account Type" <> Rec."Account Type"::Posting THEN BEGIN
                            Rec.TESTFIELD("Account Type", Rec."Account Type"::Posting);
                        END ELSE BEGIN
                            //Check Required Fields
                            CheckRequiredFields;

                            //Dialog
                            IF CONFIRM(Text0001, FALSE, Rec."Activity Code", Rec."Activity Description") = FALSE THEN EXIT;

                            //Upload to Workplan Entry Table and mark as converted to Workplan Entry

                            //Completion
                            MESSAGE(Text0002, Rec."Activity Code", Rec."Activity Description");
                        END;
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin

        UpdateControls;
    end;

    var
        [InDataSet]
        NoEmphasize: Boolean;
        [InDataSet]
        NameEmphasize: Boolean;
        [InDataSet]
        NameIndent: Integer;
        Text0001: Label 'Convert to Workplan Activity %1-%2 to a Workplan Budget Entry?';
        Text0002: Label 'Workplan Budget Entry created for Workplan Activity %1-%2.';

    procedure SetSelection(var GLAcc: Record "Workplan Activities")
    begin
        CurrPage.SETSELECTIONFILTER(GLAcc);
    end;

    procedure GetSelectionFilter(): Code[80]
    var
        GLAcc: Record "Workplan Activities";
        FirstAcc: Text[20];
        LastAcc: Text[20];
        SelectionFilter: Code[80];
        GLAccCount: Integer;
        More: Boolean;
    begin
        CurrPage.SETSELECTIONFILTER(GLAcc);
        GLAcc.SETCURRENTKEY("Activity Code");
        GLAccCount := GLAcc.COUNT;
        IF GLAccCount > 0 THEN BEGIN
            GLAcc.FIND('-');
            WHILE GLAccCount > 0 DO BEGIN
                GLAccCount := GLAccCount - 1;
                GLAcc.MARKEDONLY(FALSE);
                FirstAcc := GLAcc."Activity Code";
                LastAcc := FirstAcc;
                More := (GLAccCount > 0);
                WHILE More DO
                    IF GLAcc.NEXT = 0 THEN
                        More := FALSE
                    ELSE
                        IF NOT GLAcc.MARK THEN
                            More := FALSE
                        ELSE BEGIN
                            LastAcc := GLAcc."Activity Code";
                            GLAccCount := GLAccCount - 1;
                            IF GLAccCount = 0 THEN
                                More := FALSE;
                        END;
                IF SelectionFilter <> '' THEN
                    SelectionFilter := SelectionFilter + '|';
                IF FirstAcc = LastAcc THEN
                    SelectionFilter := SelectionFilter + FirstAcc
                ELSE
                    SelectionFilter := SelectionFilter + FirstAcc + '..' + LastAcc;
                IF GLAccCount > 0 THEN BEGIN
                    GLAcc.MARKEDONLY(TRUE);
                    GLAcc.NEXT;
                END;
            END;
        END;
        EXIT(SelectionFilter);
    end;

    procedure UpdateControls()
    begin
        /*
        IF (Type = Type::"Begin-Total") OR (Type = Type::"End-Total") THEN
        BEGIN
            FieldEditable:=FALSE;
        END ELSE
        BEGIN
            FieldEditable:=TRUE;
        END;
        */

        //For Bold and Indentation
        NoEmphasize := Rec."Account Type" <> Rec."Account Type"::Posting;
        NameIndent := Rec.Indentation;
        NameEmphasize := Rec."Account Type" <> Rec."Account Type"::Posting;

    end;

    procedure CheckRequiredFields()
    begin
        /*
        testfield(Type);
        testfield();
        testfield();
        */

    end;
}

