page 51747 "HMS Off Duty"
{
    PageType = List;
    SourceTable = "HMS-Off Duty";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Treatment No."; Rec."Treatment No.")
                {
                    ApplicationArea = All;
                }
                field("Staff No"; Rec."Staff No")
                {
                    ApplicationArea = All;
                }
                field("Staff Name"; Rec."Staff Name")
                {
                    ApplicationArea = All;
                }
                field("Off Duty Start Date"; Rec."Off Duty Start Date")
                {
                    ApplicationArea = All;
                }
                field("Contact person"; Rec."Contact person")
                {
                    ApplicationArea = All;
                }
                field("Off Duty Reason Reason"; Rec."Off Duty Reason Reason")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field("No of days"; Rec."No of days")
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
            action("&Register Referral")
            {
                Caption = '&Register Referral';
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction()
                var
                    Referral: Record "HMS-Referral Header";
                    TreatmentHeader: Record "HMS-Treatment Form Header";
                begin
                    IF CONFIRM('Register Off duty?', FALSE) = FALSE THEN BEGIN EXIT END;

                    TreatmentHeader.RESET;
                    IF TreatmentHeader.GET(Rec."Treatment No.") THEN BEGIN
                        Referral.INIT;
                        Referral."Treatment No." := Rec."Treatment No.";
                        Referral.Validate("Treatment No.");
                        Referral."Staff No" := TreatmentHeader."Employee No.";
                        Referral."Patient No." := TreatmentHeader."Patient No.";
                        //Referral."Off Duty Start Date":="Date Referred";

                        Referral.INSERT(true);
                    END;
                end;
            }

            action("Create Sick Leave Certificate")
            {
                Caption = 'Create Sick Leave Certificate';
                Image = Certificate;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = All;

                trigger OnAction()
                var
                    SickLeaveCert: Record "HMS-Off Duty";
                    SickLeavePage: Page "HMS Sick Leave Cert. Card";
                begin
                    SickLeaveCert.Init();
                    SickLeaveCert."Treatment No." := Rec."Treatment No.";
                    SickLeaveCert.Insert(true);

                    SickLeavePage.SetRecord(SickLeaveCert);
                    SickLeavePage.Run();
                end;
            }

            action("Sick Leave Certificates")
            {
                Caption = 'All Sick Leave Certificates';
                Image = List;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;
                RunObject = Page "HMS Sick Leave Cert. List";
            }
        }
    }
}

