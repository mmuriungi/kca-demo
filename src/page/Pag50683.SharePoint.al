page 50683 SharePoint

{
    Caption = 'EDMS';
    PageType = List;
    SourceTable = "EDMS Setups";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Document type"; Rec."Document type")
                {
                    ApplicationArea = all;
                }
                field(Url; Rec.Url)
                {
                    ApplicationArea = All;
                }
            }
        }
        area(factboxes)
        {
            systempart(Notes; Notes)
            {
                ApplicationArea = All;
            }
            systempart(Links; Links)
            {
                ApplicationArea = All;
            }
        }
    }


    actions
    {
        area(Processing)
        {
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
        URL: Text;
        DMS: Record "EDMS Setups";

    procedure SetURL(NavigateToURL: Text)
    begin
        Rec.Url := NavigateToURL;
    end;
}

