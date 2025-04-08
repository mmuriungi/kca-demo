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
                field("Observation Title"; DNotesText)
                {
                    Editable = AuditeeAmmend;

                    trigger OnValidate()
                    begin
                        CALCFIELDS(Description);
                        Description.CREATEINSTREAM(Instr);
                        DNotes.READ(Instr);

                        IF DNotesText <> FORMAT(DNotes) THEN BEGIN
                            CLEAR(Description);
                            CLEAR(DNotes);
                            DNotes.ADDTEXT(DNotesText);
                            Description.CREATEOUTSTREAM(OutStr);
                            DNotes.WRITE(OutStr);
                        END;
                    end;
                }
                field("Observation / Condition"; ObservationNotesTxt)
                {
                    Caption = 'Recommendation';
                    Editable = AuditeeAmmend;

                    trigger OnValidate()
                    begin
                        CALCFIELDS("Observation/Condition");
                        "Observation/Condition".CREATEINSTREAM(ObsInstr);
                        ObservationNotes.READ(ObsInstr);

                        IF ObservationNotesTxt <> FORMAT(ObservationNotes) THEN BEGIN
                            CLEAR("Observation/Condition");
                            CLEAR(ObservationNotes);
                            ObservationNotes.ADDTEXT(ObservationNotesTxt);
                            "Observation/Condition".CREATEOUTSTREAM(ObsOutStr);
                            ObservationNotes.WRITE(ObsOutStr);
                        END;
                    end;
                }
                field("Due Date"; Date)
                {
                }
                field(Remarks; Remarks)
                {
                    Caption = 'Management Response';
                }
                field(CriteriaNotesTxt; CriteriaNotesTxt)
                {
                    Caption = 'Criteria';
                    Editable = AuditeeAmmend;

                    trigger OnValidate()
                    begin
                        CALCFIELDS(Criteria);
                        Criteria.CREATEINSTREAM(CriteriaInstr);
                        CriteriaNotes.READ(CriteriaInstr);

                        IF CriteriaNotesTxt <> FORMAT(CriteriaNotes) THEN BEGIN
                            CLEAR(Criteria);
                            CLEAR(CriteriaNotes);
                            CriteriaNotes.ADDTEXT(CriteriaNotesTxt);
                            Criteria.CREATEOUTSTREAM(CriteriaOutStr);
                            CriteriaNotes.WRITE(CriteriaOutStr);
                        END;
                    end;
                }
                field(ImplicationNotesText; ImplicationNotesText)
                {
                    Caption = 'Risk Implication';
                    Editable = AuditeeAmmend;

                    trigger OnValidate()
                    begin
                        CALCFIELDS("Risk Implication");
                        "Risk Implication".CREATEINSTREAM(ImplicationInstr);
                        ImplicationNotes.READ(ImplicationInstr);

                        IF ImplicationNotesText <> FORMAT(ImplicationNotes) THEN BEGIN
                            CLEAR("Risk Implication");
                            CLEAR(ImplicationNotes);
                            ImplicationNotes.ADDTEXT(ImplicationNotesText);
                            "Risk Implication".CREATEOUTSTREAM(ImplicationOutStr);
                            ImplicationNotes.WRITE(ImplicationOutStr);
                        END;
                    end;
                }
                field("Risk Rating"; "Risk Rating")
                {
                }
                field("Responsible Personnel"; "Responsible Personnel")
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

        //Description
        CALCFIELDS(Description);
        Description.CREATEINSTREAM(Instr);
        DNotes.READ(Instr);
        DNotesText := FORMAT(DNotes);
        //

        //Risk Implication
        CALCFIELDS("Risk Implication");
        "Risk Implication".CREATEINSTREAM(ImplicationInstr);
        ImplicationNotes.READ(ImplicationInstr);
        ImplicationNotesText := FORMAT(ImplicationNotes);
        //

        //Criteria
        CALCFIELDS(Criteria);
        Criteria.CREATEINSTREAM(CriteriaInstr);
        CriteriaNotes.READ(CriteriaInstr);
        CriteriaNotesTxt := FORMAT(CriteriaNotes);
        //

        //Observation/Condition
        CALCFIELDS("Observation/Condition");
        "Observation/Condition".CREATEINSTREAM(ObsInstr);
        ObservationNotes.READ(ObsInstr);
        ObservationNotesTxt := FORMAT(ObservationNotes);
        //

        //Action Plan / Management Response
        CALCFIELDS("Action Plan / Mgt Response");
        "Action Plan / Mgt Response".CREATEINSTREAM(ResponseInstr);
        ResponseNotes.READ(ResponseInstr);
        ResponseNotesTxt := FORMAT(ResponseNotes);
        //
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
        IF AuditHeader.GET("Document No.") THEN BEGIN
            IF (AuditHeader."Report Status" = AuditHeader."Report Status"::Auditee) THEN BEGIN
                AuditeeAmmend := FALSE;
            END ELSE
                AuditeeAmmend := TRUE;
        END;
    end;
}

