page 50275 "Audit Notification Subform"
{
    PageType = ListPart;
    SourceTable = "Communication Lines";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Activity; Rec.Activity)
                {
                    ApplicationArea = All;
                }
                field("Audit Requirements"; Rec."Audit Requirements")
                {
                    ApplicationArea = All;
                }
                field("Department Name"; Rec."Department Name")
                {
                    ApplicationArea = All;
                    //Editable = false;
                }

            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Departments)
            {
                ApplicationArea = All;
                Image = Holiday;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    AuditMgt.GetAuditCommunicationDept(Rec."No.");
                end;
            }
        }
    }

    var
        CommLines: Record "Communication Lines";
        AuditMgt: Codeunit "Internal Audit Management";
}

