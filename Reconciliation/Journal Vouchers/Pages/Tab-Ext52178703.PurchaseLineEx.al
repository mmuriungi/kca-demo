// tableextension 52178703 "Purchase LineEx" extends "Purchase Line"
// {
//     fields
//     {
//         field(50101; "Institution"; code[50])
//         {
//             Caption = '';
//             DataClassification = ToBeClassified;
//         }
//         field(50102; "Procurement Plan"; code[20])
//         {
//             Caption = '';
//             DataClassification = ToBeClassified;
//         }
//         //DocApprovalType
//         field(50103; "DocApprovalType"; Option)
//         {
//             OptionMembers = " ","Requisition","Purchase Order","Invoice";
//         }
//         //Feature On The Plan
//         field(50104; "Feature On The Plan"; Boolean)
//         {
//             Caption = '';
//             DataClassification = ToBeClassified;
//         }


//         modify("No.")
//         {
//             trigger OnBeforeValidate()
//             var
//                 gl: Record "G/L Account";
//                 itm: Record Item;
//                 fa: Record "Fixed Asset";
//                 Fpg: Record "FA Posting Group";
//                 BudgetComparison: Record 52178732;
//                 Budgetsetup: record 52178700;
//                 BuddgetName: Code[20];
//             begin


//                 if "Type" = "Type"::Item then begin
//                     itm.reset;
//                     itm.SetRange("No.", "No.");
//                     if itm.Find('-') then
//                         "Vote Book" := itm."Item G/L Budget Account";
//                 end else
//                     if "Type" = "Type"::"G/L Account" then begin
//                         "Vote Book" := "No.";
//                     end else
//                         if "Type" = "Type"::"Fixed Asset" then begin
//                             fa.Reset();
//                             fa.SetRange("No.", "No.");
//                             if fa.Find('-') then begin
//                                 Fpg.Reset();
//                                 Fpg.SetRange("Code", fa."FA Posting Group");
//                                 if Fpg.Find('-') then
//                                     "Vote Book" := Fpg."Acquisition Cost Account";
//                             end;
//                         end;
//                 gl.Reset();
//                 gl.SetRange("No.", "Vote Book");
//                 if gl.Find('-') then begin
//                     "Vote Name" := gl.Name;
//                 end;




//             end;

//             trigger OnAfterValidate()
//             var
//                 gl: Record "G/L Account";
//                 itm: Record Item;
//                 fa: Record "Fixed Asset";
//                 Fpg: Record "FA Posting Group";
//             begin
//                 if "Type" = "Type"::Item then begin
//                     itm.reset;
//                     itm.SetRange("No.", "No.");
//                     if itm.Find('-') then
//                         "Vote Book" := itm."Item G/L Budget Account";
//                     GetBudgetBalances("Vote Book");
//                 end else
//                     if "Type" = "Type"::"G/L Account" then begin
//                         "Vote Book" := "No.";
//                         GetBudgetBalances("Vote Book");
//                     end else
//                         if "Type" = "Type"::"Fixed Asset" then begin
//                             fa.Reset();
//                             fa.SetRange("No.", "No.");
//                             if fa.Find('-') then begin
//                                 Fpg.Reset();
//                                 Fpg.SetRange("Code", fa."FA Posting Group");
//                                 if Fpg.Find('-') then
//                                     "Vote Book" := Fpg."Acquisition Cost Account";
//                                 GetBudgetBalances("Vote Book");
//                             end;
//                         end;
//                 gl.Reset();
//                 gl.SetRange("No.", "Vote Book");
//                 if gl.Find('-') then begin
//                     "Vote Name" := gl.Name;
//                 end;

//             end;

//         }
//         //Vote Name
//         modify("Vote Book")
//         {
//             trigger OnAfterValidate()
//             var
//                 BudgetComparison: Record 52178732;
//                 Budgetsetup: record 52178700;
//                 BuddgetName: Code[20];


//             begin

//             end;
//         }
//         field(52178700; "Vote Name"; Text[50])
//         {
//             DataClassification = ToBeClassified;
//         }
//     }
//     procedure GetBudgetBalances(VoteBook: Code[20])
//     var
//         BudgetComparison: Record "FIN-Budget Entries";
//         Budgetsetup: Record 52178700;
//         BuddgetName: Code[20];
//         BudgetedAmount: Decimal;
//         BudgetBalance: Decimal;
//     begin
//         if Budgetsetup.GET then begin
//             BuddgetName := Budgetsetup."Current Budget Code";


//             BudgetComparison.RESET;
//             BudgetComparison.SETRANGE("Budget Name", BuddgetName);
//             BudgetComparison.SETRANGE("G/L Account No.", VoteBook);
//             //BudgetComparison.SetRange("Global Dimension 1 Code", "Shortcut Dimension 1 Code");
//             // BudgetComparison.SetRange("Global Dimension 2 Code", "Shortcut Dimension 2 Code");
//             //  BudgetComparison.SetFilter(BudgetComparison."Transaction Type", '%1|%2|%3', BudgetComparison."Transaction Type"::Allocation, BudgetComparison."Transaction Type"::Commitment, BudgetComparison."Transaction Type"::Expense);

//             if BudgetComparison.FINDSET then begin
//                 repeat
//                     BudgetComparison.CalcSums(BudgetComparison.Amount);


//                     BudgetedAmount := BudgetComparison.Amount;
//                     // BudgetBalance := BudgetComparison.Amount;


//                     if BudgetComparison."Transaction Type" = BudgetComparison."Transaction Type"::Allocation then
//                         BudgetComparison.CalcSums(BudgetComparison.Amount);
//                     BudgetedAmount := BudgetComparison.Amount;
//                 until BudgetComparison.NEXT = 0;
//             end else
//                 Message('No matching records found in BudgetComparison.');
//         end else
//             Message('Budget Setup not found.');
//     end;

//     procedure CheckPlanQTY(var prline: Record "Purchase Line")
//     var
//         plHead: Record "PROC-Procurement Plan Header";
//         pLine: Record "PROC-Procurement Plan Lines";
//         qty: Decimal;
//         qtyp: Decimal;
//         qtyR: Decimal;
//     begin
//         qty := 0;
//         plHead.Reset();
//         plHead.SetRange(Active, true);
//         if plHead.Find('+') then begin
//             pLine.Reset();
//             pline.SetRange("Budget Name", plHead."Budget Name");
//             pline.SetRange("Type No", prline."No.");
//             if pLine.Find('-') then begin
//                 repeat
//                 // pLine.CalcFields("Quantity Requisitioned");
//                 // qty := qty + pLine.Quantity;
//                 // qtyp := pLine."Quantity Requisitioned";

//                 until pLine.Next() = 0;
//             end;
//             qtyR := qty - qtyp;

//             if prline.Quantity > qtyR then Error('You cannot requisition quantity Beyond Budgeted on Plan');

//         end;
//     end;

//     procedure CheckPlan(var prline: Record "Purchase Line")
//     var
//         plHead: Record "PROC-Procurement Plan Header";
//         pLine: Record "PROC-Procurement Plan Lines";
//     begin
//         plHead.Reset();
//         plHead.SetRange(Active, true);
//         if plHead.Find('+') then begin
//             pLine.Reset();
//             pline.SetRange("Budget Name", plHead."Budget Name");
//             pline.SetRange("Type No", prline."No.");
//             if not pLine.Find('-') then begin
//                 Error('The Item is not budgeted for');
//             end;

//         end else
//             Error('No Active Procurement Plan');
//     end;
// }
