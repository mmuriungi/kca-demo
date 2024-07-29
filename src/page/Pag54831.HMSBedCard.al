page 54831 "HMS Bed Card"
{
    Caption = 'Bed Card';
    PageType = Card;
    RefreshOnActivate = true;
    SourceTable = 5600;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;

                    trigger OnAssistEdit()
                    begin
                        IF Rec.AssistEdit(xRec) THEN
                            CurrPage.UPDATE;
                    end;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Serial No."; Rec."Serial No.")
                {
                    ApplicationArea = All;
                }
                field("Main Asset/Component"; Rec."Main Asset/Component")
                {
                    ApplicationArea = All;
                }
                field("Component of Main Asset"; Rec."Component of Main Asset")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                }
                field("Search Description"; Rec."Search Description")
                {
                    ApplicationArea = All;
                }
                field("Responsible Employee"; Rec."Responsible Employee")
                {
                    ApplicationArea = All;
                }
                field(Inactive; Rec.Inactive)
                {
                    ApplicationArea = All;
                }
                field(Blocked; Rec.Blocked)
                {
                    ApplicationArea = All;
                }
                field("Last Date Modified"; Rec."Last Date Modified")
                {
                    ApplicationArea = All;
                }
            }
            part(DepreciationBook; 5666)
            {
                SubPageLink = "FA No." = FIELD("No.");
                ApplicationArea = All;
            }
            group(Posting)
            {
                Caption = 'Posting';
                field("FA Class Code"; Rec."FA Class Code")
                {
                    ApplicationArea = All;
                }
                field("FA Subclass Code"; Rec."FA Subclass Code")
                {
                    ApplicationArea = All;
                }
                field("FA Location Code"; Rec."FA Location Code")
                {
                    ApplicationArea = All;
                }
                field("Budgeted Asset"; Rec."Budgeted Asset")
                {
                    ApplicationArea = All;
                }
            }
            group(Maintenance)
            {
                Caption = 'Maintenance';
                field("Vendor No."; Rec."Vendor No.")
                {
                    ApplicationArea = All;
                }
                field("Maintenance Vendor No."; Rec."Maintenance Vendor No.")
                {
                    ApplicationArea = All;
                }
                field("Under Maintenance"; Rec."Under Maintenance")
                {
                    ApplicationArea = All;
                }
                field("Next Service Date"; Rec."Next Service Date")
                {
                    ApplicationArea = All;
                }
                field("Warranty Date"; Rec."Warranty Date")
                {
                    ApplicationArea = All;
                }
                field(Insured; Rec.Insured)
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
            group("&Bed")
            {
                Caption = '&Bed';
                action("Depreciation &Books")
                {
                    Caption = 'Depreciation &Books';
                    Image = DepreciationBooks;
                    RunObject = Page 5619;
                    RunPageLink = "FA No." = FIELD("No.");
                    ApplicationArea = All;
                }
                action("Ledger E&ntries")
                {
                    Caption = 'Ledger E&ntries';
                    RunObject = Page 5604;
                    RunPageLink = "FA No." = FIELD("No.");
                    RunPageView = SORTING("FA No.");
                    ShortCutKey = 'Ctrl+F7';
                    ApplicationArea = All;
                }
                action("Error Ledger Entries")
                {
                    Caption = 'Error Ledger Entries';
                    RunObject = Page 5605;
                    RunPageLink = "Canceled from FA No." = FIELD("No.");
                    RunPageView = SORTING("Canceled from FA No.");
                    ApplicationArea = All;
                }
                action("Main&tenance Ledger Entries")
                {
                    Caption = 'Main&tenance Ledger Entries';
                    Image = MaintenanceLedgerEntries;
                    RunObject = Page 5641;
                    RunPageLink = "FA No." = FIELD("No.");
                    RunPageView = SORTING("FA No.");
                    ApplicationArea = All;
                }
                action("Co&mments")
                {
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    RunObject = Page 124;
                    RunPageLink = "Table Name" = CONST("Fixed Asset"),
                                  "No." = FIELD("No.");
                    ApplicationArea = All;
                }
                action(Dimensions)
                {
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    RunObject = Page 540;
                    RunPageLink = "Table ID" = CONST(5600),
                                  "No." = FIELD("No.");
                    ShortCutKey = 'Shift+Ctrl+D';
                    ApplicationArea = All;
                }
                action(Picture)
                {
                    Caption = 'Picture';
                    RunObject = Page 5620;
                    RunPageLink = "No." = FIELD("No.");
                    ApplicationArea = All;
                }
                action("Maintenance &Registration")
                {
                    Caption = 'Maintenance &Registration';
                    Image = MaintenanceRegistrations;
                    RunObject = Page 5625;
                    RunPageLink = "FA No." = FIELD("No.");
                    ApplicationArea = All;
                }
                action("M&ain Bed Components")
                {
                    Caption = 'M&ain Bed Components';
                    RunObject = Page 5658;
                    RunPageLink = "Main Asset No." = FIELD("No.");
                    ApplicationArea = All;
                }
                action("C&opy Bed")
                {
                    Caption = 'C&opy Bed';
                    Ellipsis = true;
                    ApplicationArea = All;

                    trigger OnAction()
                    var
                        CopyFA: Report 5685;
                    begin
                        CopyFA.SetFANo(Rec."No.");
                        CopyFA.RUNMODAL;
                    end;
                }
                separator(sep2)
                {
                    Caption = '';
                }
                action(Statistics2)
                {
                    Caption = 'Statistics';
                    Image = Statistics;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = Page 5602;
                    RunPageLink = "FA No." = FIELD("No.");
                    ShortCutKey = 'F7';
                    ApplicationArea = All;
                }
                action("Ma&in Bed Statistics")
                {
                    Caption = 'Ma&in Bed Statistics';
                    RunObject = Page 5603;
                    RunPageLink = "FA No." = FIELD("No.");
                    ApplicationArea = All;
                }
                action("FA Posting Types Overview")
                {
                    Caption = 'FA Posting Types Overview';
                    RunObject = Page 5662;
                    ApplicationArea = All;
                }
            }
            group("&Depr. Book")
            {
                Caption = '&Depr. Book';
                action("Ledger E&ntries2")
                {
                    Caption = 'Ledger E&ntries';
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        //CurrPage.DepreciationBook.PAGE.ShowFALedgEntries;
                    end;
                }
                action("Error Ledger Entries2")
                {
                    Caption = 'Error Ledger Entries';
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        //CurrPage.DepreciationBook.PAGE.ShowFAErrorLedgEntries;
                    end;
                }
                action("Maintenance Ledger Entries")
                {
                    Caption = 'Maintenance Ledger Entries';
                    Image = MaintenanceLedgerEntries;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        //CurrPage.DepreciationBook.PAGE.ShowMaintenanceLedgEntries;
                    end;
                }
                separator(sep3)
                {
                    Caption = '';
                }
                action(Statistics)
                {
                    Caption = 'Statistics';
                    Image = Statistics;
                    Promoted = true;
                    PromotedCategory = Process;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        //CurrPage.DepreciationBook.PAGE.ShowStatistics;
                    end;
                }
                action("Main &Bed Statistics")
                {
                    Caption = 'Main &Bed Statistics';
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        //CurrPage.DepreciationBook.PAGE.ShowMainAssetStatistics;
                    end;
                }
            }
        }
    }
}

