page 50160 "Converted Workplan Card"
{
    Editable = true;
    PageType = Card;
    SourceTable = "Workplan Activities";
    SourceTableView = WHERE("Converted to Budget" = FILTER(true));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                IndentationColumn = ActivitiesIndent;
                IndentationControls = "Activity Description";
                field("Activity Code"; Rec."Activity Code")
                {
                }
                field("Activity Description"; Rec."Activity Description")
                {
                }
                field("Account Type"; Rec."Account Type")
                {
                }
                field(Totaling; Rec.Totaling)
                {
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                }
                field("Converted to Budget"; Rec."Converted to Budget")
                {
                }
                field("Workplan Code"; Rec."Workplan Code")
                {
                }
                field(Indentation; Rec.Indentation)
                {
                    Editable = false;
                    Visible = false;
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
                action("Indent Workplan")
                {
                    Caption = 'Indent Workplan';
                    RunObject = Codeunit "Workplan Indent";
                }
                action("Import Workplan")
                {
                    Caption = 'Import Workplan';
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        ActivitiesIndent := 0;
        WorkPlanCodeOnFormat;
        ActivitiesOnFormat;
        TypeOnFormat;
        TotalingOnFormat;
    end;

    var
        [InDataSet]
        "WorkPlan CodeEmphasize": Boolean;
        [InDataSet]
        ActivitiesEmphasize: Boolean;
        [InDataSet]
        ActivitiesIndent: Integer;
        [InDataSet]
        TypeEmphasize: Boolean;
        [InDataSet]
        TotalingEmphasize: Boolean;

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

    local procedure WorkPlanCodeOnFormat()
    begin
        "WorkPlan CodeEmphasize" := Rec."Account Type" <> Rec."Account Type"::Posting;
    end;

    local procedure ActivitiesOnFormat()
    begin
        ActivitiesIndent := Rec.Indentation;
        ActivitiesEmphasize := Rec."Account Type" <> Rec."Account Type"::Posting;
    end;

    local procedure TypeOnFormat()
    begin
        TypeEmphasize := Rec."Account Type" <> Rec."Account Type"::Posting;
    end;

    local procedure TotalingOnFormat()
    begin
        TotalingEmphasize := Rec."Account Type" <> Rec."Account Type"::Posting;
    end;
}

