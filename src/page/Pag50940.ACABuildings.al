page 50940 "ACA-Buildings"
{
    PageType = Card;
    SourceTable = "ACA-Building";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Building)
            {
                Caption = 'Building';
                action("Lecture Rooms")
                {
                    Caption = 'Lecture Rooms';
                    RunObject = Page "ACA-Lecture Rooms";
                    RunPageLink = "Building Code" = FIELD(Code);
                    ApplicationArea = All;
                }

                action(Labs)
                {
                    Caption = 'Labs';
                    RunObject = Page "ACA-Lecture Rooms - Labs";
                    RunPageLink = "Building Code" = FIELD(Code);
                    ApplicationArea = All;
                }
            }
        }
    }
}

