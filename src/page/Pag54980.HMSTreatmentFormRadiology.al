page 54980 "HMS-Treatment Form Radiology"
{
    PageType = ListPart;
    SourceTable = "HMS-Treatment Form Radiology";

    layout
    {
        area(content)
        {
            repeater(rep)
            {
                field("Radiology Type Code"; Rec."Radiology Type Code")
                {
                    ApplicationArea = All;
                }
                field("Radiology Type Name"; Rec."Radiology Type Name")
                {
                    ApplicationArea = All;
                }
                field("Date Due"; Rec."Date Due")
                {
                    ApplicationArea = All;
                }
                field("Radiology Remarks"; Rec."Radiology Remarks")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("&Request Tests")
            {
                Caption = '&Request Tests';
                ApplicationArea = All;

                trigger OnAction()
                begin
                    IF CONFIRM('Send Radiology Request?', FALSE) = FALSE THEN BEGIN EXIT END;

                    HMSSetup.RESET;
                    HMSSetup.GET();
                    NewNo := NoSeriesMgt.GetNextNo(HMSSetup."Radiology Nos", 0D, TRUE);
                    TreatmentHeader.RESET;
                    IF TreatmentHeader.GET(Rec."Treatment No.") THEN BEGIN
                        RadiologyHeader.RESET;
                        RadiologyHeader.INIT;
                        RadiologyHeader."Radiology No." := NewNo;
                        RadiologyHeader."Radiology Date" := TODAY;
                        RadiologyHeader."Radiology Time" := TIME;
                        RadiologyHeader."Radiology Area" := RadiologyHeader."Radiology Area"::Doctor;
                        RadiologyHeader."Patient No." := TreatmentHeader."Patient No.";
                        RadiologyHeader."Student No." := TreatmentHeader."Student No.";
                        RadiologyHeader."Employee No." := TreatmentHeader."Employee No.";
                        RadiologyHeader."Relative No." := TreatmentHeader."Relative No.";
                        RadiologyHeader."Link No." := TreatmentHeader."Treatment No.";
                        RadiologyHeader."Link Type" := 'Doctor';
                        RadiologyHeader.INSERT();

                        /*Insert the lines*/
                        TreatmentLine.RESET;
                        TreatmentLine.SETRANGE(TreatmentLine."Treatment No.", Rec."Treatment No.");
                        IF TreatmentLine.FIND('-') THEN BEGIN
                            REPEAT
                                RadiologyLine.RESET;
                                RadiologyLine.INIT;
                                RadiologyLine."Radiology no." := NewNo;
                                RadiologyLine."Radiology Type Code" := TreatmentLine."Radiology Type Code";
                                RadiologyLine.INSERT();
                            UNTIL TreatmentLine.NEXT = 0;
                        END;
                    END;
                    REPORT.RUN(39005796, TRUE, TRUE, TreatmentHeader);
                    MESSAGE('Radiology Test Request Forwarded');

                end;
            }
        }
    }

    var
        TreatmentHeader: Record "HMS-Treatment Form Header";
        TreatmentLine: Record "HMS-Treatment Form Radiology";
        RadiologyHeader: Record "HMS-Radiology Form Header";
        RadiologyLine: Record "HMS-Radiology Form Line";
        NewNo: Code[20];
        NoSeriesMgt: Codeunit 396;
        HMSSetup: Record "HMS-Setup";
}

