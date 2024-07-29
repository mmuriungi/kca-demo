page 54809 "HMS Admission Form Drug"
{
    PageType = ListPart;
    SourceTable = "HMS-Admission Drug Prescribe";

    layout
    {
        area(content)
        {
            repeater(" ")
            {
                field("Pharmacy Code"; Rec."Pharmacy Code")
                {
                    ApplicationArea = All;
                }
                field("Drug No."; Rec."Drug No.")
                {
                    ApplicationArea = All;
                }
                field("Drug Name"; Rec."Drug Name")
                {
                    ApplicationArea = All;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                }
                field("Unit Of Measure"; Rec."Unit Of Measure")
                {
                    ApplicationArea = All;
                }
                field(Dosage; Rec.Dosage)
                {
                    ApplicationArea = All;
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = All;
                }
                field("Marked as Incompatible"; Rec."Marked as Incompatible")
                {
                    ApplicationArea = All;
                }
                field(Issued; Rec.Issued)
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Actual Quantity Issued"; Rec."Actual Quantity Issued")
                {
                    ApplicationArea = All;
                }
                field("Remaining Quantity"; Rec."Remaining Quantity")
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
            action("&Prescribe Drugs")
            {
                Caption = '&Prescribe Drugs';

                ApplicationArea = All;

                trigger OnAction()
                begin
                    IF CONFIRM('Alert Pharmacy About Prescription?') = FALSE THEN BEGIN EXIT END;
                    HMSSetup.RESET;
                    HMSSetup.GET();
                    NewNo := NoSeriesMgt.GetNextNo(HMSSetup."Pharmacy Nos", 0D, TRUE);

                    /*Get the treatment from the database*/
                    AdmissionHeader.RESET;
                    IF AdmissionHeader.GET(Rec."Admission No.") THEN BEGIN
                        PharmHeader.RESET;
                        PharmHeader.INIT;
                        PharmHeader."Pharmacy No." := NewNo;
                        PharmHeader."Pharmacy Date" := TODAY;
                        PharmHeader."Pharmacy Time" := TIME;
                        PharmHeader."Request Area" := PharmHeader."Request Area"::Doctor;
                        PharmHeader."Patient No." := AdmissionHeader."Patient No.";
                        PharmHeader."Student No." := AdmissionHeader."Student No.";
                        PharmHeader."Employee No." := AdmissionHeader."Employee No.";
                        PharmHeader."Relative No." := AdmissionHeader."Relative No.";
                        PharmHeader."Link Type" := 'Admission';
                        PharmHeader."Link No." := Rec."Admission No.";
                        PharmHeader.INSERT();

                        AdmissionLine.RESET;
                        AdmissionLine.SETRANGE(AdmissionLine."Admission No.", Rec."Admission No.");
                        IF AdmissionLine.FIND('-') THEN BEGIN
                            REPEAT
                                PharmLine.INIT;
                                PharmLine."Pharmacy No." := NewNo;
                                PharmLine."Drug No." := AdmissionLine."Drug No.";
                                PharmLine.Quantity := AdmissionLine.Quantity;
                                PharmLine.VALIDATE(PharmLine.Quantity);
                                PharmLine."Measuring Unit" := AdmissionLine."Unit Of Measure";
                                PharmLine.VALIDATE(PharmLine.Quantity);
                                PharmLine.Dosage := AdmissionLine.Dosage;
                                PharmLine.Pharmacy := AdmissionLine."Pharmacy Code";
                                PharmLine.INSERT();
                            UNTIL AdmissionLine.NEXT = 0;
                        END;
                        MESSAGE('The Prescription has been sent to the Pharmacy for Issuance');
                    END;

                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        PharmacyCodeOnFormat;
        DrugNoOnFormat;
        DrugNameOnFormat;
        QuantityOnFormat;
        UnitOfMeasureOnFormat;
        DosageOnFormat;
        RemarksOnFormat;
        ActualQuantityIssuedOnFormat;
        RemainingQuantityOnFormat;
    end;

    var
        HMSSetup: Record "HMS-Setup";
        NoSeriesMgt: Codeunit 396;
        NewNo: Code[20];
        AdmissionHeader: Record "HMS-Admission Form Header";
        AdmissionLine: Record "HMS-Admission Drug Prescribe";
        PharmHeader: Record "HMS-Pharmacy Header";
        PharmLine: Record "HMS-Pharmacy Line";

    local procedure PharmacyCodeOnFormat()
    begin
        IF Rec."Marked as Incompatible" = TRUE THEN;
    end;

    local procedure DrugNoOnFormat()
    begin
        IF Rec."Marked as Incompatible" = TRUE THEN;
    end;

    local procedure DrugNameOnFormat()
    begin
        IF Rec."Marked as Incompatible" = TRUE THEN;
    end;

    local procedure QuantityOnFormat()
    begin
        IF Rec."Marked as Incompatible" = TRUE THEN;
    end;

    local procedure UnitOfMeasureOnFormat()
    begin
        IF Rec."Marked as Incompatible" = TRUE THEN;
    end;

    local procedure DosageOnFormat()
    begin
        IF Rec."Marked as Incompatible" = TRUE THEN;
    end;

    local procedure RemarksOnFormat()
    begin
        IF Rec."Marked as Incompatible" = TRUE THEN;
    end;

    local procedure ActualQuantityIssuedOnFormat()
    begin
        IF Rec."Marked as Incompatible" = TRUE THEN;
    end;

    local procedure RemainingQuantityOnFormat()
    begin
        IF Rec."Marked as Incompatible" = TRUE THEN;
    end;
}

