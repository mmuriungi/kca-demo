page 51513 "Maintenance Officers"
{
    Caption = 'Maintenance Officers';
    PageType = ListPart;
    SourceTable = "Maintenance Officer";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field("M.O"; Rec."Officer Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Officer Name field.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Phone No."; Rec."Phone No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Phone No. field.';
                }
                field("E-Mail"; Rec."E-Mail")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the E-Mail field.';
                }
                field("Date Assigned"; Rec."Date Assigned")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Date Assigned field.';
                }
                field("Survey Feedback"; Rec."Repair Feedback")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Estimated End Date"; Rec."Estimated End Date")
                {
                    ApplicationArea = All;
                }
                field("Repair Period"; Rec."Repair Period")
                {
                    ApplicationArea = Basic, Suite;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("Completion FeedBack"; rec."Completion FeedBack")
                {
                    ApplicationArea = Basic, Suite;
                }

                field(Completed; Rec.Completed)
                {
                    ApplicationArea = Basic, Suite;
                }
                field("client feedback"; rec."client feedback")
                {
                    ApplicationArea = Basic, Suite;
                }
                field("client Closed"; rec."client Closed")
                {
                    ApplicationArea = Basic, Suite;
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Required Items")
            {
                Image = ItemAvailabilitybyPeriod;
                ApplicationArea = Basic, Suite;
                RunObject = page "Required Items/Assets";
                RunPageLink = "Maintenance Officer" = field("No.");
            }

            action("Notify Customer")
            {
                Caption = 'Notify Customer';
                Image = Email;
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'Send a notification email about this customer.';

                trigger OnAction()
                var
                //SendEmailNotification: Codeunit "Send Email Notification";
                begin
                    //  SendEmailNotification.SendEmailNotification(Rec);
                    Message('Notification email sent to default email address.');
                end;
            }


        }
    }
}
