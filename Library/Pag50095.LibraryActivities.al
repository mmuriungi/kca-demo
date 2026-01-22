page 50095 "Library Activities"
{
    Caption = 'Library Activities';
    PageType = CardPart;
    RefreshOnActivate = true;

    layout
    {
        area(content)
        {
            cuegroup("Library Patrons")
            {
                Caption = 'Library Patrons';

                field(Students; StudentsCount)
                {
                    Caption = 'Students';
                    ApplicationArea = All;
                    DrillDownPageId = "Library Student Card";

                    trigger OnDrillDown()
                    var
                        Student: Record Customer;
                    begin
                        Student.Reset();
                        Student.SetRange("Customer Type", Student."Customer Type"::Student);
                        Page.Run(Page::"Library Student Card", Student);
                    end;
                }

                field(Staff; StaffCount)
                {
                    Caption = 'Staff';
                    ApplicationArea = All;
                    DrillDownPageId = "HRM-Employee List";

                    trigger OnDrillDown()
                    var
                        Employee: Record "HRM-Employee C";
                    begin
                        Employee.Reset();
                        Page.Run(Page::"HRM-Employee List", Employee);
                    end;
                }

                field(SyncedToKoha; SyncedToKohaCount)
                {
                    Caption = 'Synced to Koha';
                    ApplicationArea = All;
                    DrillDownPageId = "Library Student Card";

                    trigger OnDrillDown()
                    var
                        Student: Record Customer;
                    begin
                        Student.Reset();
                        Student.SetFilter("Library Username", '<>%1', '');
                        Page.Run(Page::"Library Student Card", Student);
                    end;
                }
            }

            cuegroup("Library Items")
            {
                Caption = 'Library Items';

                field(Books; BooksCount)
                {
                    Caption = 'Books';
                    ApplicationArea = All;
                    DrillDownPageId = "Item List";

                    trigger OnDrillDown()
                    var
                        Item: Record Item;
                    begin
                        Item.Reset();
                        Item.SetRange("Item Category Code", 'BOOKS');
                        Page.Run(Page::"Item List", Item);
                    end;
                }

                field(Journals; JournalsCount)
                {
                    Caption = 'Journals';
                    ApplicationArea = All;
                    DrillDownPageId = "Item List";

                    trigger OnDrillDown()
                    var
                        Item: Record Item;
                    begin
                        Item.Reset();
                        Item.SetRange("Item Category Code", 'JOURNALS');
                        Page.Run(Page::"Item List", Item);
                    end;
                }

                field(DigitalResources; DigitalResourcesCount)
                {
                    Caption = 'Digital Resources';
                    ApplicationArea = All;
                    DrillDownPageId = "Item List";

                    trigger OnDrillDown()
                    var
                        Item: Record Item;
                    begin
                        Item.Reset();
                        Item.SetRange("Item Category Code", 'DIGITAL');
                        Page.Run(Page::"Item List", Item);
                    end;
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        CalculateCounts();
    end;

    trigger OnAfterGetRecord()
    begin
        CalculateCounts();
    end;

    procedure CalculateCounts()
    var
        Student: Record Customer;
        Employee: Record "HRM-Employee C";
        Item: Record Item;
    begin
        // Calculate patron counts
        Student.Reset();
        Student.SetRange("Customer Type", Student."Customer Type"::Student);
        StudentsCount := Student.Count;

        Employee.Reset();
        StaffCount := Employee.Count;

        Student.Reset();
        Student.SetFilter("Library Username", '<>%1', '');
        SyncedToKohaCount := Student.Count;

        // Calculate item counts
        Item.Reset();
        Item.SetRange("Item Category Code", 'BOOKS');
        BooksCount := Item.Count;

        Item.Reset();
        Item.SetRange("Item Category Code", 'JOURNALS');
        JournalsCount := Item.Count;

        Item.Reset();
        Item.SetRange("Item Category Code", 'DIGITAL');
        DigitalResourcesCount := Item.Count;
    end;

    var
        StudentsCount: Integer;
        StaffCount: Integer;
        SyncedToKohaCount: Integer;
        BooksCount: Integer;
        JournalsCount: Integer;
        DigitalResourcesCount: Integer;
}
