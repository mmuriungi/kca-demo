page 54851 "HMS Immunization Header"
{
    PageType = Document;
    SourceTable = "HMS-Immunization";
    SourceTableView = WHERE(Posted = CONST(false));

    layout
    {
        area(content)
        {
            group(grp)
            {
                field(Select; Rec.Select)
                {
                    ApplicationArea = All;
                }
                field("No."; Rec."No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Immunization Date"; Rec."Immunization Date")
                {
                    ApplicationArea = All;
                }
                field("Immunization Time"; Rec."Immunization Time")
                {
                    ApplicationArea = All;
                }
                field("Patient Type"; Rec."Patient Type")
                {
                    ApplicationArea = All;
                }
                field("Patient No."; Rec."Patient No.")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        Patient.RESET;
                        IF Patient.GET(Rec."Patient No.") THEN BEGIN
                            Rec."Patient Name" := Patient.Surname + ' ' + Patient."Middle Name" + ' ' + Patient."Last Name";
                        END;
                    end;
                }
                field("Patient Name"; Rec."Patient Name")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Immunization No."; Rec."Immunization No.")
                {
                    ApplicationArea = All;
                }
                field("Immunization Name"; Rec."Immunization Name")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Given; Rec.Given)
                {
                    ApplicationArea = All;
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("&Post Immunizations")
            {
                Caption = '&Post Immunizations';
                Image = PostApplication;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    IF CONFIRM('Do you wish to make the Immunization records permanent?', FALSE) = FALSE THEN BEGIN EXIT END;
                    Imm.RESET;
                    Imm.SETRANGE(Imm.Posted, FALSE);
                    Imm.SETRANGE(Imm.Select, TRUE);
                    IF Imm.FIND('-') THEN BEGIN
                                              REPEAT
                                                  Imm.Posted := TRUE;
                                                  Imm.Select := FALSE;
                                                  Imm.MODIFY;
                                              UNTIL Imm.NEXT = 0;
                        MESSAGE('Immunization records made permanent');
                    END;
                end;
            }
        }
    }

    var
        Patient: Record "HMS-Patient";
        Imm: Record "HMS-Immunization";
}

