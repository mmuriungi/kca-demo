page 54481 "Incoming Mails"
{
    CardPageId = "Incoming Mail Card";
    Editable = false;
    PageType = List;
    SourceTable = "Incoming Mail";
    SourceTableView = where(status = filter(Open));

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Ref No"; Rec."Ref No")
                {
                    ApplicationArea = all;
                }
                field("Mail Subject"; Rec."Mail Subject")
                {
                    ApplicationArea = All;
                }
                field("Date Received"; Rec."Date Received")
                {
                    ApplicationArea = all;
                }
                field("Incoming Mail"; Rec."Incoming Mail")
                {
                    ApplicationArea = all;
                }
                field(Department; Rec.Department)
                {
                    ApplicationArea = All;
                }
                field("Received By"; Rec."Received By")
                {
                    ApplicationArea = All;
                }
                field(status; Rec.status)
                {
                    ApplicationArea = all;
                }
            }
        }


    }
    actions
    {
        area(Processing)
        {
            action(Approvals)
            {
                ApplicationArea = All;
                Image = Approvals;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "Approval Entries";
                RunPageLink = "Document No." = field("Ref No");
            }
            action(Sharepoint)
            {
                ApplicationArea = all;

                Image = Attach;
                Promoted = true;
                PromotedCategory = Process;
                trigger OnAction()
                begin
                    DMS.Reset;
                    DMS.SetRange("Document Type", DMS."Document Type"::"Incoming Mail");
                    if DMS.Find('-') then begin
                        Hyperlink(DMS."url" + Rec."Ref No")
                    end else
                        Message('No Link ' + format(DMS."Document Type"::"Incoming Mail"))
                end;

            }

        }

    }
    var
        DMS: Record "EDMS Setups";

}
