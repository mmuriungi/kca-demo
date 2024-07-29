page 54994 "HMIS-Registration Card"
{
    PageType = Card;
    SourceTable = "HMIS-Visits/Registrations";

    layout
    {
        area(content)
        {
            group(Group)
            {
                field("Batch Date"; Rec."Batch Date")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("Visit Number"; Rec."Visit Number")
                {
                    Visible = false;
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
                        CurrPage.Update;
                    end;
                }
                field("First Name"; Rec."First Name")
                {
                    Enabled = false;
                    ApplicationArea = All;
                }
                field("Other Names"; Rec."Other Names")
                {
                    Enabled = false;
                    ApplicationArea = All;
                }
                field("Pay Mode"; Rec."Pay Mode")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        Clear(InsuRanceExists);
                        if Rec."Pay Mode" = Rec."Pay Mode"::Insurance then InsuRanceExists := true else InsuRanceExists := false;
                    end;
                }
                field("In-patient No."; Rec."In-patient No.")
                {
                    Enabled = false;
                    ApplicationArea = All;
                }
                field("Out-Patient No."; Rec."Out-Patient No.")
                {
                    Enabled = false;
                    ApplicationArea = All;
                }
                field("Registration Time"; Rec."Registration Time")
                {
                    Enabled = false;
                    ApplicationArea = All;
                }
                field(Discharged; Rec.Discharged)
                {
                    Enabled = false;
                    ApplicationArea = All;
                }
                field("Discharge Date/Time"; Rec."Discharge Date/Time")
                {
                    Enabled = false;
                    ApplicationArea = All;
                }
                field("Discharged by"; Rec."Discharged by")
                {
                    Enabled = false;
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    Enabled = false;
                    ApplicationArea = All;
                }
                field("Insurance Card No."; Rec."Insurance Card No.")
                {
                    ApplicationArea = All;
                }
                field("Insurance Firm Code"; Rec."Insurance Firm Code")
                {
                    ApplicationArea = All;
                }
                field("Insurance Name"; Rec."Insurance Name")
                {
                    Editable = InsuRanceExists;
                    ApplicationArea = All;
                }
                field("Insurance Cap (Outpatient)"; Rec."Insurance Cap (Outpatient)")
                {
                    ApplicationArea = All;
                }
                field("Insurance Cap (inpatient)"; Rec."Insurance Cap (inpatient)")
                {
                    ApplicationArea = All;
                }
                field("Insurance Verified"; Rec."Insurance Verified")
                {
                    ApplicationArea = All;
                }
                field("Insurance Veriyfied by"; Rec."Insurance Veriyfied by")
                {
                    Editable = false;
                    Enabled = false;
                    ApplicationArea = All;
                }
                field("Insurance Verified Date"; Rec."Insurance Verified Date")
                {
                    Editable = false;
                    Enabled = false;
                    ApplicationArea = All;
                }
                field("Current Location"; Rec."Current Location")
                {
                    Enabled = false;
                    ApplicationArea = All;
                }
                field("Temperature (Celcious)"; Rec."Temperature (Celcious)")
                {
                    Enabled = false;
                    ApplicationArea = All;
                }
                field("Height (CM)"; Rec."Height (CM)")
                {
                    Enabled = false;
                    ApplicationArea = All;
                }
                field("Weight (KGs)"; Rec."Weight (KGs)")
                {
                    Enabled = false;
                    ApplicationArea = All;
                }
                field(BMI; Rec.BMI)
                {
                    Enabled = false;
                    ApplicationArea = All;
                }
                field("Previous Temperature (Cel.)"; Rec."Previous Temperature (Cel.)")
                {
                    Enabled = false;
                    ApplicationArea = All;
                }
                field("Previous Height (CM)"; Rec."Previous Height (CM)")
                {
                    Enabled = false;
                    ApplicationArea = All;
                }
                field("Previous Weight (KGs)"; Rec."Previous Weight (KGs)")
                {
                    Enabled = false;
                    ApplicationArea = All;
                }
                field("Previous BMI"; Rec."Previous BMI")
                {
                    Enabled = false;
                    ApplicationArea = All;
                }
                field("Triage By"; Rec."Triage By")
                {
                    Enabled = false;
                    ApplicationArea = All;
                }
                field("Test Date/Time"; Rec."Test Date/Time")
                {
                    Enabled = false;
                    ApplicationArea = All;
                }
                field("Referal No."; Rec."Referal No.")
                {
                    ApplicationArea = All;
                }
                field("Consultation Assigned to"; Rec."Consultation Assigned to")
                {
                    ApplicationArea = All;
                }
                field("External Referal Hospital Name"; Rec."External Referal Hospital Name")
                {
                    ApplicationArea = All;
                }
                field("Consultation Assigned"; Rec."Consultation Assigned")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        Clear(InsuRanceExists);
        if Rec."Pay Mode" = Rec."Pay Mode"::Insurance then InsuRanceExists := true else InsuRanceExists := false;
    end;

    var
        InsuRanceExists: Boolean;
}

