codeunit 50024 "Leave Carry Forward"
{

    trigger OnRun()
    begin

        if Confirm('Generate Leave Balances to Carry Forward? (Ensure that you have already allocated annual leave balances)', true) = false then exit;
        Clear(ints);
        hremployee2.Reset;
        //hremployee.SetRange(hremployee.Status, hremployee.Status::Normal);
        hremployee2.SetRange(hremployee2.Status, hremployee2.Status::Active);
        if hremployee2.Find('-') then begin
            // Populate leave journal with

            // Delete Existing Journal Entries first
            leaveJournal.Reset;
            if leaveJournal.Find('-') then
                leaveJournal.DeleteAll;
            repeat

            begin
                IF hremployee2."No." <> ''
                then begin
                    leaveledger.Reset;
                    //leaveledger.SetRange(leaveledger."Document No", hremployee2."No.");
                    leaveledger.SetRange(leaveledger."Employee No", hremployee2."No.");
                    //leaveledger.SetRange(leaveledger."Leave Period", (Date2DMY(Today, 3) - 1));
                    leaveledger.SetRange(leaveledger."Leave Period", Date2DMY(Today, 3));
                    //leaveledger.SetFilter(leaveledger."Transaction Type", '<>%1', leaveledger."Transaction Type"::"Positive Adjustment");
                    //leaveledger.SetFilter(leaveledger."Entry Type", '<>%1', leaveledger."Entry Type"::Allocation);
                    //if not leaveledger.Find('-') then begin
                    if leaveledger.Find('-') then begin
                        // Insert the Journals

                        ints := ints + 1;

                        CFDays := salaryGrades."Annual Leave Days" / 2;
                        if bal > 0 then begin
                            if bal > CFDays then
                                bal := CFDays;

                            leaveJournal.Init;
                            leaveJournal."Line No." := ints;
                            leaveJournal."Staff No." := hremployee2."No.";
                            leaveJournal."Staff Name" := hremployee2."First Name" + ' ' + hremployee2."Middle Name" + ' ' + hremployee2."Last Name";
                            leaveJournal."Transaction Description" := 'Leave Carry Forward for ' + Format(Date2DMY(Today, 3));
                            leaveJournal."Leave Type" := 'ANNUAL';
                            //leaveJournal."No. of Days" := salaryGrades."Annual Leave Days";
                            leaveJournal."No. of Days" := bal;
                            leaveJournal."Transaction Type" := leaveJournal."Transaction Type"::"Positive Adjustment";
                            leaveJournal."Document No." := 'ALL-' + Format(Date2DMY(Today, 3));
                            leaveJournal."Posting Date" := Today;
                            leaveJournal."Leave Period" := Date2DMY(Today, 3);
                            leaveJournal.Insert;
                        end;
                    end;
                    //end;
                end;
            end;
            until hremployee2.Next = 0;
        end;
        Message('Annual Leave balance generated successfully!');
    end;

    var
        salaryGrades: Record "HRM-Job_Salary grade/steps";
        hremployee: Record "HRM-Employee C";
        hremployee2: Record "HRM-Employee C";
        leaveledger: Record "HRM-Leave Ledger";
        leaveJournal: Record "HRM-Employee Leave Journal";
        ints: Integer;
        bal: Decimal;
        CFDays: Decimal;
}

