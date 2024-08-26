page 52000 "CA-CSR Director registry. List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "CA-CSR Requisition";
    CardPageId = "CA-CSR Req. Card";
    SourceTableView = WHERE(Status = FILTER("Open" | "Pending Approval"), "CSR Stage" = FILTER('Director'));

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
                field("CSR Stage"; Rec."CSR Stage")
                {
                    Editable = true;
                    ApplicationArea = All;
                }

            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Submit to DDCAQA")
            {
                Caption = 'Submit to DDCAQA';
                Image = Approval;
                ApplicationArea = All;

                trigger OnAction()
                begin

                    IF CONFIRM('Are you sure you want to send to DDCAQA?') THEN BEGIN
                        Rec."CSR Stage" := Rec."CSR Stage"::DDCAQA;
                        Rec.MODIFY;
                        MESSAGE('Appraisal  Number %1 has been Sent to DDCAQA', Rec."Code");
                    END;
                end;
            }
        }
    }

    var
        myInt: Integer;
}