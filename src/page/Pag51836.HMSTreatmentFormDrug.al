page 51836 "HMS-Treatment Form Drug"
{
    PageType = ListPart;
    SourceTable = "HMS-Treatment Form Drug";

    layout
    {
        area(content)
        {
            repeater(rep)
            {

                field("Drug No."; Rec."Drug No.")
                {
                    ApplicationArea = All;
                }
                field("Drug Name"; Rec."Drug Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Route of Administration"; rec."Route of Administration")
                {
                    ApplicationArea = All;
                }
                field("Quantity of Issues"; Rec.Quantity)
                {
                    Caption = 'Quantity of Issues';
                    ApplicationArea = All;
                    visible=false;
                    trigger OnValidate()
                    var

                    begin
                       // rec." Total Number Of Tablets" := rec.Quantity * rec."Dosage Frequencies " * rec."Number Of Days";
                        //rec." Total Cost" := rec." Total Number Of Tablets" * rec."unit cost ";
                        //rec.Modify();
                        CurrPage.Update();
                    end;

                }
                field("Dosage Frequencies "; rec."Dosage Frequencies ")
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    var

                    begin
                     ///   rec." Total Number Of Tablets" := rec.Quantity * rec."Dosage Frequencies " * rec."Number Of Days";
                       // rec." Total Cost" := rec." Total Number Of Tablets" * rec."unit cost ";
                      //  rec.Modify();
                        CurrPage.Update();
                    end;
                }
                field("Number Of Days"; rec."Number Of Days")
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    var

                    begin
                     //   rec." Total Number Of Tablets" := rec.Quantity * rec."Dosage Frequencies " * rec."Number Of Days";
                     //   rec." Total Cost" := rec." Total Number Of Tablets" * rec."unit cost ";
                     //   rec.Modify();
                        CurrPage.Update();

                    end;
                }
                field(" Total Number Of Tablets"; rec." Total Number Of Tablets")
                {
                    ApplicationArea = All;
                    
                    trigger OnValidate()
                    var

                    begin

                       // rec." Total Number Of Tablets" := rec.Quantity * rec."Dosage Frequencies " * rec."Number Of Days";
                       // rec." Total Cost" := rec." Total Number Of Tablets" * rec."unit cost ";
                      //  rec.Modify();
                        CurrPage.Update();
                    end;

                }
                field("unit cost "; rec."unit cost ")
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    var

                    begin

                        // rec." Total Number Of Tablets" := rec.Quantity * rec."Dosage Frequencies " * rec."Number Of Days";
                        // rec." Total Cost" := rec." Total Number Of Tablets" * rec."unit cost ";
                        // rec.Modify();
                        CurrPage.Update();
                    end;
                }
                field(" Total Cost"; rec." Total Cost")
                {
                    ApplicationArea = All;
                }
                field("Unit Of Measure"; Rec."Unit Of Measure II")
                {
                    ApplicationArea = All;
                    Editable = false;
                }

                field("Quantity In Store"; Rec."Quantity In Store")
                {
                    Editable = false;
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Quantity In Store field.';
                }

                field(Dosage; Rec.Dosage)
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    var

                    begin

                        // rec." Total Number Of Tablets" := rec.Quantity * rec."Dosage Frequencies " * rec."Number Of Days";
                        // rec." Total Cost" := rec." Total Number Of Tablets" * rec."unit cost ";
                        // rec.Modify();
                        CurrPage.Update();
                    end;
                }
                // 
                field("Quantity to issue"; Rec."Quantity to issue")
                {
                    ApplicationArea = All;
                    Caption = 'Quantity Issued';
                    ToolTip = 'Quantity actually issued to patient';
                }
                field(Issued; Rec.Issued)
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
                    TreatmentHeader.RESET;
                    IF TreatmentHeader.GET(Rec."Treatment No.") THEN BEGIN
                        PharmHeader.RESET;
                        PharmHeader.INIT;
                        PharmHeader."Pharmacy No." := NewNo;
                        PharmHeader."Pharmacy Date" := TODAY;
                        PharmHeader."Pharmacy Time" := TIME;
                        PharmHeader."Request Area" := PharmHeader."Request Area"::Doctor;
                        PharmHeader."Patient No." := TreatmentHeader."Patient No.";
                        PharmHeader."Student No." := TreatmentHeader."Student No.";
                        PharmHeader."Employee No." := TreatmentHeader."Employee No.";
                        PharmHeader."Relative No." := TreatmentHeader."Relative No.";
                        PharmHeader."Link Type" := 'Doctor';
                        PharmHeader."Link No." := Rec."Treatment No.";
                        PharmHeader.INSERT();

                        TreatmentLine.RESET;
                        TreatmentLine.SETRANGE(TreatmentLine."Treatment No.", Rec."Treatment No.");
                        IF TreatmentLine.FIND('-') THEN BEGIN
                            REPEAT
                                PharmLine.INIT;
                                PharmLine."Pharmacy No." := NewNo;
                                PharmLine."Drug No." := TreatmentLine."Drug No.";
                                PharmLine.Quantity := TreatmentLine.Quantity;
                                PharmLine.VALIDATE(PharmLine.Quantity);
                                PharmLine."Measuring Unit" := TreatmentLine."Unit Of Measure";
                                PharmLine.VALIDATE(PharmLine.Quantity);
                                PharmLine.Dosage := TreatmentLine.Dosage;
                                PharmLine.Pharmacy := TreatmentLine."Pharmacy Code";
                                PharmLine."No Stock Drugs" := TreatmentLine."No stock Drugs";
                                PharmLine.INSERT(True);
                            UNTIL TreatmentLine.NEXT = 0;
                        END;
                        MESSAGE('The Prescription has been sent to the Pharmacy for Issuance');
                    END;

                end;
            }
            action(PrescripedForm)
            {
                ApplicationArea = All;
                RunObject = report "Prescription Drugs";

            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        DrugNoOnFormat;
        DrugNameOnFormat;
        QuantityOnFormat;
        UnitOfMeasureOnFormat;
        DosageOnFormat;
    end;

    var
        HMSSetup: Record "HMS-Setup";
        NoSeriesMgt: Codeunit 396;
        NewNo: Code[20];
        TreatmentHeader: Record "HMS-Treatment Form Header";
        TreatmentLine: Record "HMS-Treatment Form Drug";
        PharmHeader: Record "HMS-Pharmacy Header";
        PharmLine: Record "HMS-Pharmacy Line";

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
}

