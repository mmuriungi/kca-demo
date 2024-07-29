page 50942 "HRM-Emp. Leave Journal Lines"
{
    PageType = List;
    SourceTable = "HRM-Employee Leave Journal";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Line No."; Rec."Line No.")
                {
                    ApplicationArea = all;
                }
                field("Staff No."; Rec."Staff No.")
                {
                    ApplicationArea = all;
                }
                field("Staff Name"; Rec."Staff Name")
                {
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = all;
                }
                field("Transaction Description"; Rec."Transaction Description")
                {
                    ApplicationArea = all;
                }
                field("Leave Type"; Rec."Leave Type")
                {
                    ApplicationArea = all;
                }
                field("No. of Days"; Rec."No. of Days")
                {
                    ApplicationArea = all;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = all;
                }
                field("Transaction Type"; Rec."Transaction Type")
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(Post_Leave)
            {
                ApplicationArea = all;
                Caption = 'Post Leave Journal';
                Image = PostDocument;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;


                trigger OnAction()
                begin
                    CODEUNIT.Run(Codeunit::"HR Post Leave Journal Ent.");
                end;
            }
        }
        area(creation)
        {
            action(GetAnnual_Leave)
            {
                ApplicationArea = all;
                Caption = 'Get Monthly Leave Allocations';
                Image = GetLines;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = New;


                trigger OnAction()
                begin
                    if Confirm('Generate annual Leave allocations?', true) = false then exit;
                    Clear(ints);
                    hremployee.Reset;
                    hremployee.SetRange(hremployee.Status, hremployee.Status::Active);
                    if hremployee.Find('-') then begin
                        // Populate leave journal with

                        // Delete Existing Journal Entries first
                        leaveJournal.Reset;
                        if leaveJournal.Find('-') then
                            leaveJournal.DeleteAll;
                        repeat
                        begin
                            if ((hremployee."Salary Category" <> '') and (hremployee."Salary Grade" <> '')) then begin
                                salaryGrades.Reset;
                                salaryGrades.SetRange(salaryGrades."Employee Category", hremployee."Salary Category");
                                salaryGrades.SetRange(salaryGrades."Salary Grade code", hremployee."Salary Grade");
                                if salaryGrades.Find('-') then begin
                                    if salaryGrades."Annual Leave Days" <> 0 then begin

                                        // populate the Journal
                                        leaveledger.Reset;
                                        leaveledger.SetRange(leaveledger."Document No", hremployee."No.");
                                        leaveledger.SetRange(leaveledger."Leave Period", Date2DMY(Today, 3));
                                        leaveledger.SetFilter(leaveledger."Entry Type", '<>%1', leaveledger."Entry Type"::Allocation);
                                        if not leaveledger.Find('-') then begin
                                            // Insert the Journals

                                            ints := ints + 1;
                                            leaveJournal.Init;
                                            leaveJournal."Line No." := ints;
                                            leaveJournal."Staff No." := hremployee."No.";
                                            leaveJournal."Staff Name" := hremployee."First Name" + ' ' + hremployee."Middle Name" + ' ' + hremployee."Last Name";
                                            leaveJournal."Transaction Description" := 'Leave Allocations for ' + Format(Date2DMY(Today, 3));
                                            leaveJournal."Leave Type" := 'ANNUAL';
                                            leaveJournal."No. of Days" := salaryGrades."Annual Leave Days";
                                            leaveJournal."Transaction Type" := leaveJournal."Transaction Type"::Allocation;
                                            leaveJournal."Document No." := 'ALL-' + Format(Date2DMY(Today, 3));
                                            leaveJournal."Posting Date" := Today;
                                            leaveJournal."Leave Period" := Date2DMY(Today, 3);
                                            leaveJournal.Insert;
                                        end;

                                    end;
                                end;
                            end;
                        end;
                        until hremployee.Next = 0;
                    end;
                    Message('Annual leave days generated successfully!');
                end;
            }


            group(Import)
            {

                Caption = '&Actions';
                action("Import Leave Balances")
                {
                    Caption = 'Import Leave Balances';
                    Image = ImportExcel;
                    Promoted = true;
                    PromotedIsBig = true;
                    ApplicationArea = all;
                    PromotedCategory = New;

                    trigger OnAction()
                    begin
                        if Confirm('!!!!!!!!!!!!!!!!!!!!....................... IMPORTANT.................!!!!!!!!!!!!!!!!!!!!!!!\' +
                        'Please ensure that your data is saved in ''.CSV'' format i.e. Comma delimeted.' +
                        '\The data should be in the following format:\' +
                        ' Line No|Staff No|Name|Description|Leave Type|No. of Days|Trans Type|Doc. No|Post Date|Leave Period.\' +
                        '\' +
                        '...........................EXAMPLE.........................\' +
                        '1|0001|Wanjala Tom|2015Leave days|ANNUAL|23|ALLOCATION|leave_2015|22012015|2015\' +
                        '2|0002|Jacinta Mwali|2015Leave days|ANNUAL|23|ALLOCATION|leave_2015|22012015|2015\' +
                        '\' +
                        'Continue?', true) = false then
                            Error('Cancelled by user!');
                        XMLPORT.Run(Xmlport::"Leave Allocations", false, true);
                        Message('Imported Successfully!');
                    end;
                }
            }
        }
    }

    var
        salaryGrades: Record "HRM-Job_Salary grade/steps";
        hremployee: Record "HRM-Employee C";
        leaveledger: Record "HRM-Leave Ledger";
        leaveJournal: Record "HRM-Employee Leave Journal";
        ints: Integer;
}

