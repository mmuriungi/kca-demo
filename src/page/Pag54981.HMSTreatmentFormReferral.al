page 54981 "HMS-Treatment Form Referral"
{
    PageType = ListPart;
    SourceTable = "HMS-Treatment Referral";

    layout
    {
        area(content)
        {
            repeater(rep)
            {
                field("Date Referred"; Rec."Date Referred")
                {
                    ApplicationArea = All;
                }
                field("Hospital No."; Rec."Hospital No.")
                {

                    ApplicationArea = All;
                }
                field("Hospital Name"; Rec."Hospital Name")
                {
                    Editable = false;
                    ApplicationArea = All;
                }

                field("Referral Reason"; Rec."Referral Reason")
                {
                    ApplicationArea = All;
                }
                field("Referral Remarks"; Rec."Referral Remarks")
                {
                    ApplicationArea = All;
                }
                field("Phone No."; Rec."Phone No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Phone No. field.';
                }

            }
        }
    }

    actions
    {
        area(processing)
        {
            action("&Register Referral")
            {
                Caption = '&Register Referral';
                ApplicationArea = All;

                trigger OnAction()
                begin
                    IF CONFIRM('Register Referral?', FALSE) = FALSE THEN BEGIN EXIT END;

                    TreatmentHeader.RESET;
                    IF TreatmentHeader.GET(Rec."Treatment No.") THEN BEGIN
                        Referral.INIT;
                        Referral."Treatment no." := Rec."Treatment No.";
                        Referral."Hospital No." := Rec."Hospital No.";
                        Referral."Patient No." := TreatmentHeader."Patient No.";
                        Referral."Date Referred" := Rec."Date Referred";
                        Referral."Referral Reason" := Rec."Referral Reason";
                        Referral."Referral Remarks" := Rec."Referral Remarks";
                        Referral.INSERT();
                    END;
                end;
            }
        }
    }

    var
        Referral: Record "HMS-Referral Header";
        TreatmentHeader: Record "HMS-Treatment Form Header";
}

