page 50159 "Proc. Plan Activities Card"
{
    Caption = 'Procurement Plan Activities Card';
    PageType = List;
    SourceTable = "Workplan Activities";

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
                field(Type; Rec."Type")
                {
                }
                field("Default RFP Code"; Rec."Default RFP Code")
                {
                }
                field("Account Type"; Rec."Account Type")
                {
                }
                field(Status; Rec.Status)
                {
                }
                field("No."; Rec."No.")
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
                field("Workplan Code"; Rec."Workplan Code")
                {
                }
                field("Converted to Budget"; Rec."Converted to Budget")
                {
                }
                field("Strategic Plan Code"; Rec."Strategic Plan Code")
                {
                }
                field("Strategic Plan Desc"; Rec."Strategic Plan Desc")
                {
                }
                field("Medium term Plan Code"; Rec."Medium term Plan Code")
                {
                }
                field("Medium term  Plan Desc"; Rec."Medium term  Plan Desc")
                {
                }
                field("PC Code"; Rec."PC Code")
                {
                }
                field("PC Name"; Rec."PC Name")
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
            action(Convert)
            {
                Caption = 'Convert';
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                begin
                    xRec."Converted to Budget" := FALSE;
                    Workplan.RESET;
                    IF Workplan.FIND('-') THEN
                        Rec."Converted to Budget" := TRUE;
                    REPEAT
                        Rec."Converted to Budget" := TRUE;
                    UNTIL Workplan.NEXT = 0;
                    Rec.MODIFY;
                    //END;
                end;
            }
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
        Workplan: Record "Workplan";
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

    procedure SetSelection(var GLAcc: Record "Workplan")
    begin
    end;

    procedure GetSelectionFilter(): Code[80]
    var
        GLAcc: Record "Workplan";
        FirstAcc: Text[20];
        LastAcc: Text[20];
        SelectionFilter: Code[80];
        GLAccCount: Integer;
        More: Boolean;
    begin
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

