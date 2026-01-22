page 51941 "Audit General SetUp"
{
    PageType = Card;
    SourceTable = "Audit General SetUp";
    Editable = true;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Student Nos."; rec."Student Nos.")
                {
                    ApplicationArea = all;
                }
                field("Registration Nos."; rec."Registration Nos.")
                {
                    ApplicationArea = all;
                }
                field("'----------------------**************---------------------'"; '----------------------**************---------------------')
                {
                    Caption = '----------------------HOSTEL ALLOCATION POLICY---------------------';
                    ApplicationArea = All;
                }
                field("% of Accomodation"; rec."% of Accomodation")
                {
                    ApplicationArea = all;
                }
                field("% of Billed Fees/Balance"; rec."% of Billed Fees/Balance")
                {
                    ApplicationArea = all;
                }
                field("Receipt Nos."; rec."Receipt Nos.")
                {
                    ApplicationArea = all;
                }
                field("Class Allocation Nos."; rec."Class Allocation Nos.")
                {
                    ApplicationArea = all;
                }
                field("Defered Account"; rec."Defered Account")
                {
                    ApplicationArea = all;
                }
                field("Over Payment Account"; rec."Over Payment Account")
                {
                    ApplicationArea = all;
                }
                field("Transaction Nos."; rec."Transaction Nos.")
                {
                    ApplicationArea = all;
                }
                field("Pre-Payment Account"; rec."Pre-Payment Account")
                {
                    ApplicationArea = all;
                }
                field("Cons. Marksheet Key2"; rec."Cons. Marksheet Key2")
                {
                    ApplicationArea = All;
                }
                field("Bill Supplimentary Fee"; rec."Bill Supplimentary Fee")
                {
                    ApplicationArea = all;
                }
                field("Supplimentary Fee Code"; rec."Supplimentary Fee Code")
                {
                    ApplicationArea = all;
                }
                field("Unallocated Rcpts Account"; rec."Unallocated Rcpts Account")
                {
                    ApplicationArea = all;
                }
                field("Further Info Nos"; rec."Further Info Nos")
                {
                    ApplicationArea = all;
                }
                field("Medical Condition Nos"; rec."Medical Condition Nos")
                {
                    ApplicationArea = all;
                }
                field("Attachment Nos"; rec."Attachment Nos")
                {
                    ApplicationArea = all;
                }
                field("Enquiry Nos"; rec."Enquiry Nos")
                {
                    ApplicationArea = all;
                }
                field("Application Fee"; rec."Application Fee")
                {
                    ApplicationArea = all;
                }
                field("Clearance Nos"; rec."Clearance Nos")
                {
                    ApplicationArea = all;
                }
                field("Proforma Nos"; rec."Proforma Nos")
                {
                    ApplicationArea = all;
                }
                field("Allow Posting From"; rec."Allow Posting From")
                {
                    ApplicationArea = all;
                }
                field("Allow Posting To"; rec."Allow Posting To")
                {
                    ApplicationArea = all;
                }
                field("Applications Date Line"; rec."Applications Date Line")
                {
                    ApplicationArea = all;
                }
                field("Default Year"; rec."Default Year")
                {
                    ApplicationArea = all;
                }
                field("Default Semester"; rec."Default Semester")
                {
                    ApplicationArea = all;
                }
                field("Default Intake"; rec."Default Intake")
                {
                    ApplicationArea = all;
                }
                field("Default Academic Year"; rec."Default Academic Year")
                {
                    ApplicationArea = all;
                }
                field("Allow UnPaid Hostel Booking"; rec."Allow UnPaid Hostel Booking")
                {
                    ApplicationArea = all;
                }
                field("Cons. Marksheet Key1"; rec."Cons. Marksheet Key1")
                {
                    ApplicationArea = all;
                }
                field("Allowed Reg. Fees Perc."; rec."Allowed Reg. Fees Perc.")
                {
                    ApplicationArea = All;
                }
                field("Allow Online Results Access"; rec."Allow Online Results Access")
                {
                    ApplicationArea = All;
                }
                field("Base Date"; rec."Base Date")
                {
                    ApplicationArea = All;
                }
                field("Helb Account"; rec."Helb Account")
                {
                    ApplicationArea = All;
                }
                field("CDF Account"; rec."CDF Account")
                {
                    ApplicationArea = All;
                }
                field("Hostel Incidents"; rec."Hostel Incidents")
                {
                    ApplicationArea = All;
                }
                // field("Supplimentary Code";"Supplimentary Code")
                // {
                // }
                field("Supplimentary Fee"; rec."Supplimentary Fee")
                {
                    ApplicationArea = All;
                }
                // field("Special Exam Code";"Special Exam Code")
                // {
                // }
                field("Special Exam Fee"; rec."Special Exam Fee")
                {
                    ApplicationArea = All;
                }
            }
            group("ID Setup")
            {
                Caption = 'ID Setup';
                field(Picture; rec.Picture)
                {
                    Caption = 'Signature';
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Action1102760018)
            {
                Promoted = true;
                PromotedCategory = Process;
                Visible = false;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    /*
                    CReg.RESET;
                    CReg.SETRANGE(CReg."System Created",TRUE);
                    IF CReg.FIND('-') THEN
                    CReg.DELETEALL;
                    */
                    //Evaluate(PDate,'01/09/08');

                    // SCharges.Reset;
                    // SCharges.SetFilter(SCharges.Stage,'Y1S2..Y4S2');
                    // SCharges.SetRange(SCharges.Recognized,false);
                    // if SCharges.Find('-') then
                    // SCharges.ModifyAll(SCharges.Date,PDate);
                    // //SCharges.MODIFYALL(SCharges.Recognized,FALSE);

                end;
            }
            action("Temp Del")
            {
                Enabled = false;
                ApplicationArea = All;

                trigger OnAction()
                begin

                    //  CReg.DELETEALL;
                    // Cust.DELETEALL;
                    //SCharges.DELETEALL;
                    //StudUnit.DELETEALL;
                    //Prog.DELETEALL;
                    //Units.DELETEALL;

                    // Cust.DELETEALL;
                    // GLEntry.DeleteAll;
                    // CustEntry.DeleteAll;
                    // CustDet.DeleteAll;
                    // BankL.DeleteAll;
                    // vendL.DeleteAll;
                    // vedDetailed.DeleteAll;


                    /*
                    ProgStage.DELETEALL;
                    //ProgSem.DELETEALL;
                    //Prog.SETRANGE(Prog."School Code",'003');
                    IF Prog.FIND('-') THEN BEGIN
                    REPEAT
                    
                    ProgStage.INIT;
                    ProgStage."Programme Code":=Prog.Code;
                    ProgStage.Code:='Y1S1';
                    ProgStage.Description:='Year 1 Semester1';
                    ProgStage.Remarks:='Pass, Proceed to Second Year';
                    ProgStage.INSERT;
                    ProgStage.INIT;
                    ProgStage."Programme Code":=Prog.Code;
                    ProgStage.Code:='Y1S2';
                    ProgStage.Description:='Year 1 Semester2';
                    ProgStage.Remarks:='Pass, Proceed to Second Year';
                    ProgStage.INSERT;
                    ProgStage.INIT;
                    ProgStage."Programme Code":=Prog.Code;
                    ProgStage.Code:='Y2S1';
                    ProgStage.Description:='Year 2 Semester1';
                    ProgStage.Remarks:='Pass, Proceed to Third Year';
                    ProgStage.INSERT;
                    
                    ProgStage.INIT;
                    ProgStage."Programme Code":=Prog.Code;
                    ProgStage.Code:='Y2S2';
                    ProgStage.Description:='Year 2 Semester2';
                    ProgStage.Remarks:='Pass, Proceed to Third Year';
                    ProgStage.INSERT;
                    ProgStage.INIT;
                    ProgStage."Programme Code":=Prog.Code;
                    ProgStage.Code:='Y3S1';
                    ProgStage.Description:='Year 3 Semester1';
                    ProgStage.Remarks:='Pass, Proceed to Forth Year';
                    ProgStage.INSERT;
                    
                    ProgStage.INIT;
                    ProgStage."Programme Code":=Prog.Code;
                    ProgStage.Code:='Y3S2';
                    ProgStage.Description:='Year 3 Semester2';
                    ProgStage.Remarks:='Pass, Proceed to Second Year';
                    ProgStage.INSERT;
                    
                    ProgStage.INIT;
                    ProgStage."Programme Code":=Prog.Code;
                    ProgStage.Code:='Y4S1';
                    ProgStage.Description:='Year 4 Semester1';
                    ProgStage.Remarks:='Pass ';
                    ProgStage.INSERT;
                    
                    ProgStage.INIT;
                    ProgStage."Programme Code":=Prog.Code;
                    ProgStage.Code:='Y4S2';
                    ProgStage.Description:='Year 4 Semester2';
                    ProgStage.Remarks:='Pass ';
                    ProgStage.INSERT;
                    
                    ProgSem.INIT;
                    ProgSem."Programme Code":=Prog.Code;
                    ProgSem.Semester:='Sem1 09/10';
                    ProgSem.INSERT;
                    ProgSem.INIT;
                    ProgSem.Semester:='Sem2 09/10';
                    ProgSem."Programme Code":=Prog.Code;
                    ProgSem.INSERT;
                    ProgSem.INIT;
                    ProgSem.Semester:='Sem1 10/11';
                    ProgSem."Programme Code":=Prog.Code;
                    ProgSem.INSERT;
                    ProgSem.INIT;
                    ProgSem.Semester:='Sem2 10/11';
                    ProgSem."Programme Code":=Prog.Code;
                    ProgSem.INSERT;
                    ProgSem.INIT;
                    ProgSem.Semester:='Sem1 11/12';
                    ProgSem."Programme Code":=Prog.Code;
                    ProgSem.INSERT;
                    ProgSem.INIT;
                    ProgSem.Semester:='Sem2 11/12';
                    ProgSem."Programme Code":=Prog.Code;
                    ProgSem.INSERT;
                    ProgSem.INIT;
                    ProgSem.Semester:='Sem1 12/13';
                    ProgSem."Programme Code":=Prog.Code;
                    ProgSem.INSERT;
                    ProgSem.INIT;
                    ProgSem.Semester:='Sem2 12/13';
                    ProgSem."Programme Code":=Prog.Code;
                    ProgSem.INSERT;
                    ProgSem.INIT;
                    ProgSem.Semester:='Sem1 13/14';
                    ProgSem."Programme Code":=Prog.Code;
                    ProgSem.INSERT;
                    ProgSem.INIT;
                    ProgSem.Semester:='Sem2 13/14';
                    ProgSem."Programme Code":=Prog.Code;
                    ProgSem.INSERT;
                    ProgSem.INIT;
                    ProgSem.Semester:='Sem1 14/15';
                    ProgSem."Programme Code":=Prog.Code;
                    ProgSem.INSERT;
                    ProgSem.INIT;
                    ProgSem."Programme Code":=Prog.Code;
                    ProgSem.Semester:='Sem2 14/15';
                    ProgSem.INSERT;
                    ProgSem.INIT;
                    ProgSem.Semester:='Sem1 08/09';
                    ProgSem."Programme Code":=Prog.Code;
                    ProgSem.INSERT;
                    ProgSem.INIT;
                    ProgSem."Programme Code":=Prog.Code;
                    ProgSem.Semester:='Sem2 08/09';
                    ProgSem.INSERT;
                    ProgSem.INIT;
                    ProgSem."Programme Code":=Prog.Code;
                    ProgSem.Semester:='Sem3 08/09';
                    ProgSem.INSERT;
                    ProgSem.INIT;
                    ProgSem."Programme Code":=Prog.Code;
                    ProgSem.Semester:='Sem3 09/10';
                    ProgSem.INSERT;
                    ProgSem.INIT;
                    ProgSem."Programme Code":=Prog.Code;
                    ProgSem.Semester:='Sem3 10/11';
                    ProgSem.INSERT;
                    ProgSem.INIT;
                    ProgSem."Programme Code":=Prog.Code;
                    ProgSem.Semester:='Sem3 11/12';
                    ProgSem.INSERT;
                    ProgSem.INIT;
                    ProgSem."Programme Code":=Prog.Code;
                    ProgSem.Semester:='Sem3 12/13';
                    ProgSem.INSERT;
                    ProgSem.INIT;
                    ProgSem."Programme Code":=Prog.Code;
                    ProgSem.Semester:='Sem3 13/14';
                    ProgSem.INSERT;
                    ProgSem.INIT;
                    ProgSem.Semester:='Sem1 15/16';
                    ProgSem."Programme Code":=Prog.Code;
                    ProgSem.INSERT;
                    ProgSem.INIT;
                    ProgSem."Programme Code":=Prog.Code;
                    ProgSem.Semester:='Sem2 15/16';
                    ProgSem.INSERT;
                    ProgSem.INIT;
                    ProgSem."Programme Code":=Prog.Code;
                    ProgSem.Semester:='Sem3 15/16';
                    ProgSem.INSERT;
                    
                    UNTIL Prog.NEXT=0;
                    END;
                    
                    
                    JabBuff.RESET;
                    IF JabBuff.FIND('-') THEN BEGIN
                    REPEAT
                    JabBuff.Processed:=FALSE;
                    JabBuff.MODIFY;
                    UNTIL JabBuff.NEXT=0;
                    END;
                    */
                    //Admissions.DELETEALL;
                    //}
                    Message('Done');

                end;
            }
            action("Update Units")
            {
                ApplicationArea = All;

                trigger OnAction()
                begin
                    /*
                    CReg.RESET;
                    CReg.SETRANGE(CReg.Semester,'SEM2-2014/2015');
                    IF CReg.FIND('-') THEN BEGIN
                    REPEAT
                    CReg.VALIDATE(CReg."Registration Date");
                    UNTIL
                    CReg.NEXT=0;
                    END;
                    // */
                    // StudUnit.Reset;
                    // if StudUnit.Find('-') then begin
                    // repeat
                    // StudUnit.Taken:=true;
                    // StudUnit.Modify;
                    // until StudUnit.Next=0;
                    // end;
                    // Message('Done');

                end;
            }
            action(UPD)
            {
                ApplicationArea = All;

                trigger OnAction()
                begin
                    //HMSP.DeleteAll;
                    Message('Done');
                end;
            }
            action("Process Raw Marks")
            {
                ApplicationArea = All;

                trigger OnAction()
                begin
                    // RawMarks.Reset;
                    // RawMarks.SetRange(RawMarks.Posted,false);
                    // if RawMarks.Find('-') then begin
                    // repeat
                    // if not Cust.Get(RawMarks."Reg No") then begin
                    // Cust.Init;
                    // Cust."No.":=RawMarks."Reg No";
                    // Cust.Name:=RawMarks.Name;
                    // Cust."Customer Type":=Cust."Customer Type"::Student;
                    // Cust."Customer Posting Group":='Customer';
                    // Cust."Gen. Bus. Posting Group":='LOCAL';
                    // Cust.Insert;
                    // end;
                    // CReg.Reset;
                    // CReg.SetRange(CReg."Student No.",RawMarks."Reg No");
                    // CReg.SetRange(CReg.Programme,RawMarks.Prog);
                    // CReg.SetRange(CReg.Stage,RawMarks.Stage);
                    // CReg.SetRange(CReg.Semester,RawMarks.Semester);
                    // if not CReg.Find('-') then begin
                    // CReg.Init;
                    // CReg."Reg. Transacton ID":='RG-0001';
                    // CReg."Student No.":=RawMarks."Reg No";
                    // CReg.Programme:=RawMarks.Prog;
                    // CReg.Stage:=RawMarks.Stage;
                    // CReg."Intake Code":=RawMarks.Intake;
                    // CReg.Session:=RawMarks.Session;
                    // CReg.Semester:=RawMarks.Semester+' '+RawMarks."Academic year";
                    // CReg."Settlement Type":=RawMarks."Stud Type";
                    // CReg."Registration Date":=Today;
                    // CReg."Academic Year":=RawMarks."Academic year" ;
                    // CReg.Insert;
                    // end;

                    // for i:=1 to 8 do begin
                    // RawMarks1.Reset;
                    // RawMarks1.SetRange(RawMarks1."Entry No",RawMarks."Entry No");
                    // if RawMarks1.Find('-') then begin
                    // Units.Reset;
                    // Units.SetRange(Units."Programme Code",RawMarks1.Prog);
                    // Units.SetRange(Units."Stage Code",RawMarks1.Stage );
                    // Units.SetRange(Units."Reserved Room",Format(i));
                    // if Units.Find('-') then begin
                    // StudUnit.Reset;
                    // StudUnit.SetRange(StudUnit."Student No.",RawMarks1."Reg No");
                    // StudUnit.SetRange(StudUnit.Unit,Units.Code);
                    // if not StudUnit.Find('-') then begin
                    // StudUnit.Init;
                    // StudUnit.Programme:=RawMarks1.Prog;
                    // StudUnit.Stage:=RawMarks1.Stage;
                    // StudUnit.Unit:=Units.Code;
                    // StudUnit.Semester:=RawMarks.Semester+' '+RawMarks."Academic year";
                    // StudUnit."Reg. Transacton ID":='RG-0001';
                    // StudUnit."Student No.":=RawMarks1."Reg No";
                    // StudUnit."No. Of Units":=RawMarks1.Unit;
                    // StudUnit.Taken:=true;
                    // StudUnit.Insert;
                    // end;
                    // ExResults.Reset;
                    // ExResults.SetRange(ExResults."Student No.",RawMarks1."Reg No");
                    // ExResults.SetRange(ExResults.Unit,Units.Code);
                    // if not ExResults.Find('-') then begin
                    // ExResults.Init;
                    // ExResults."Student No.":=RawMarks1."Reg No";
                    // ExResults.Programme:=RawMarks1.Prog;
                    // ExResults.Stage:=RawMarks1.Stage;
                    // ExResults.Unit:=Units.Code;
                    // ExResults.Semester:= RawMarks.Semester+' '+RawMarks."Academic year";
                    // ExResults.ExamType:='EXAM';
                    // ExResults."Reg. Transaction ID":='RG-0001';
                    // ExResults.Exam:='EXAM';
                    // if i=1 then begin
                    // ExResults.Score:=RawMarks1.U1;
                    // ExResults.Contribution:=RawMarks1.U1;
                    // end;
                    // if i=2 then begin
                    // ExResults.Score:=RawMarks1.U2;
                    // ExResults.Contribution:=RawMarks1.U2;
                    // end;
                    // if i=3 then begin
                    // ExResults.Score:=RawMarks1.U3;
                    // ExResults.Contribution:=RawMarks1.U3;
                    // end;
                    // if i=4 then begin
                    // ExResults.Score:=RawMarks1.U4;
                    // ExResults.Contribution:=RawMarks1.U4;
                    // end;
                    // if i=5 then begin
                    // ExResults.Score:=RawMarks1.U5;
                    // ExResults.Contribution:=RawMarks1.U5;
                    // end;
                    // if i=6 then begin
                    // ExResults.Score:=RawMarks1.U6;
                    // ExResults.Contribution:=RawMarks1.U6;
                    // end;
                    // if i=7 then begin
                    // ExResults.Score:=RawMarks1.U7;
                    // ExResults.Contribution:=RawMarks1.U7;
                    // end;
                    // if i=8 then begin
                    // ExResults.Score:=RawMarks1.U8;
                    // ExResults.Contribution:=RawMarks1.U8;
                    // end;
                    // ExResults.Insert;
                    // end;
                    // end;
                    // end;

                    // end;

                    // until RawMarks.Next=0;
                    // end;
                    // Message('Done');
                end;
            }
        }
    }

    var
        //CReg: Record "ACA-Course Registration";
        //SCharges: Record "ACA-Std Charges";
        PDate: Date;
        // StudUnit: Record "ACA-Student Units";
        // Prog: Record "ACA-Programme";
        // Units: Record "ACA-Units/Subjects";
        //  ProgStage: Record "ACA-Programme Stages";
        Cust: Record Customer;
        GLEntry: Record "G/L Entry";
        CustEntry: Record "Cust. Ledger Entry";
        CustDet: Record "Detailed Cust. Ledg. Entry";
        // ProgSem: Record "ACA-Programme Semesters";
        //JabBuff: Record "ACA-Raw KUCCPS Imports";
        //HMSP: Record "HMS-Patient";
        // RawMarks: Record "ACA-Raw Marks";
        //RawMarks1: Record "ACA-Raw Marks";
        i: Integer;
        // ExResults: Record "ACA-Exam Results";
        //Admissions: Record "ACA-Adm. Form Header";
        BankL: Record "Bank Account Ledger Entry";
        vendL: Record "Vendor Ledger Entry";
        vedDetailed: Record "Detailed Vendor Ledg. Entry";
}

