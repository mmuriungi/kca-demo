/// <summary>
/// Page HRM-Emp Resp. Center Card (ID 52178657).
/// </summary>
page 51212 "HRM-Emp Resp. Center Card"
{
    Caption = 'Responsibility Center Card';
    PageType = Document;
    SourceTable = "Responsibility Center";

    layout
    {
        area(content)
        {
            field("Code"; Rec.Code)
            {
            }
            field(Name; Rec.Name)
            {
            }
            field(Address; Rec.Address)
            {
            }
            field("Address 2"; Rec."Address 2")
            {
            }
            field(City; Rec.City)
            {
            }
            field("Post Code"; Rec."Post Code")
            {
            }
            // field("Country Code";"Country Code")
            // {
            // }
            field("Phone No."; Rec."Phone No.")
            {
            }
            field("Fax No."; Rec."Fax No.")
            {
            }
            field("Name 2"; Rec."Name 2")
            {
            }
            field(Contact; Rec.Contact)
            {
            }
            field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
            {
            }
            field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
            {
            }
            field("Location Code"; Rec."Location Code")
            {
            }
            field(County; Rec.County)
            {
            }
            field("E-Mail"; Rec."E-Mail")
            {
            }
            field("Home Page"; Rec."Home Page")
            {
            }
            field("Date Filter"; Rec."Date Filter")
            {
            }
            field("Contract Gain/Loss Amount"; Rec."Contract Gain/Loss Amount")
            {
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group("&Resp. Ctr.")
            {
                Caption = '&Resp. Ctr.';
                action(Dimensions)
                {
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    RunObject = Page "Default Dimensions";
                    RunPageLink = "Table ID" = CONST(5714),
                                  "No." = FIELD(Code);
                    ShortCutKey = 'Shift+Ctrl+D';
                }
            }
        }
    }

    var
        Mail: Codeunit Mail;
        Emp: Record "HRM-Employee C";
}

