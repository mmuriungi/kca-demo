page 50213 "Audit Report UnFav Observation"
{
    AutoSplitKey = true;
    PageType = ListPart;
    SourceTable = "Audit Lines";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Observation Title"; Rec.Description)
                {
                    Editable = AuditeeAmmend;

                    trigger OnValidate()
                    begin

                    end;
                }
                field("Observation / Condition"; Rec."Observation/Condition")
                {
                    Caption = 'Recommendation';
                    Editable = AuditeeAmmend;

                    trigger OnValidate()
                    begin
                    end;
                }
                field("Due Date"; Rec.Date)
                {
                }
                field(Remarks; Rec.Remarks)
                {
                    Caption = 'Management Response';
                }
                field(CriteriaNotesTxt; Rec.Criteria)
                {
                    Caption = 'Criteria';
                    Editable = AuditeeAmmend;

                    trigger OnValidate()
                    begin
                    end;
                }
                field(ImplicationNotesText; Rec."Risk Implication")
                {
                    Caption = 'Risk Implication';
                    Editable = AuditeeAmmend;

                    trigger OnValidate()
                    begin
                    end;
                }
                field("Action Plan / Mgt Response"; Rec."Action Plan / Mgt Response")
                {
                }
                field("Risk Rating"; Rec."Risk Rating")
                {
                }
                field("Responsible Personnel"; Rec."Responsible Personnel")
                {
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        SetControlApp;
    end;

    trigger OnOpenPage()
    begin

        SetControlApp;
    end;

    var
        DNotes: BigText;
        Instr: InStream;
        DNotesText: Text;
        OutStr: OutStream;
        ImplicationNotes: BigText;
        ImplicationNotesText: Text;
        CriteriaNotes: BigText;
        CriteriaNotesTxt: Text;
        ObservationNotes: BigText;
        ObservationNotesTxt: Text;
        ResponseNotes: BigText;
        ResponseNotesTxt: Text;
        ImplicationInstr: InStream;
        ImplicationOutStr: OutStream;
        CriteriaInstr: InStream;
        CriteriaOutStr: OutStream;
        ObsInstr: InStream;
        ObsOutStr: OutStream;
        ResponseInstr: InStream;
        ResponseOutStr: OutStream;
        AuditeeAmmend: Boolean;

    local procedure SetControlApp()
    var
        AuditHeader: Record "Audit Header";
    begin
        //TESTFIELD("Document No.");
        IF AuditHeader.GET(Rec."Document No.") THEN BEGIN
            IF (AuditHeader."Report Status" = AuditHeader."Report Status"::Auditee) THEN BEGIN
                AuditeeAmmend := FALSE;
            END ELSE
                AuditeeAmmend := TRUE;
        END;
    end;
}

