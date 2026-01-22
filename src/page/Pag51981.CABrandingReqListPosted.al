page 51981 "CA-Branding Req. List-Posted"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "CA-Branding Requisition";
    CardPageId = "CA-Branding Req. Card";
    SourceTableView = WHERE(Status = FILTER(Released));

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(Code; Rec.Code)
                {
                    ApplicationArea = All;

                }
                field(Region; Rec.Region)
                {
                    ApplicationArea = All;

                }
                field("Cost Center"; Rec."Cost Center")
                {
                    ApplicationArea = All;

                }
                field("Required Date"; Rec."Required Date")
                {
                    ApplicationArea = All;

                }
                field("User Id"; Rec."User Id")
                {
                    Editable = false;
                    ApplicationArea = All;
                }

            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction()
                begin

                end;
            }
        }
    }

    var
        myInt: Integer;
}