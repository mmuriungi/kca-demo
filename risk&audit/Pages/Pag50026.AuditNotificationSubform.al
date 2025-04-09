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
                }
                field("Audit Requirements"; Rec."Audit Requirements")
                {

                }
                field("Department Name"; Rec."Department Name")
                {
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

