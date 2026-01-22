page 52004 "CA-CSR DDCAQA. List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "CA-CSR Requisition";
    CardPageId = "CA-CSR Req. Card";
    SourceTableView = WHERE(Status = FILTER("Open" | "Pending Approval"), "CSR Stage" = FILTER('DDCAQA'));


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
            action("Submit to SCM")
            {
                Caption = 'Submit to SCM';
                Image = Approval;
                ApplicationArea = All;

                trigger OnAction()
                begin

                    IF CONFIRM('Are you sure you want to send to SCM?') THEN BEGIN
                        Rec."CSR Stage" := Rec."CSR Stage"::SCM;
                        Rec.MODIFY;
                        MESSAGE('Appraisal  Number %1 has been Sent to SCM', Rec."Code");
                    END;
                end;
            }
        }
    }

    var
        myInt: Integer;
}