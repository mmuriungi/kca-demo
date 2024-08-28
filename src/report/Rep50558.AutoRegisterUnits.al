report 50558 AutoRegisterUnits
{
    ProcessingOnly = true;

    dataset
    {
        dataitem("ACA-Course Registration"; "ACA-Course Registration")
        {
            RequestFilterFields = Semester;

            trigger OnAfterGetRecord()
            begin
                "ACA-Course Registration".Reset();
                "ACA-Course Registration".SetRange(Stage, 'Y1S1');
                "ACA-Course Registration".SetRange(Status, "ACA-Course Registration".Status::Current);
                if "ACA-Course Registration".Find('-') then begin
                    repeat
                        studUnits.Reset();
                        studUnits.SetRange(studUnits."Student No.", "ACA-Course Registration"."Student No.");
                        studUnits.SetRange(studUnits.Stage, 'Y1S1');
                        if not studUnits.Find('-') then begin
                            studUnits.DeleteAll();
                            unitsSUB.Reset();
                            unitsSUB.SetRange("Programme Code", "ACA-Course Registration".Programmes);
                            unitsSUB.SetRange("Stage Code", 'Y1S1');
                            if unitsSUB.Find('-') then begin
                                repeat
                                    studUnits.Init();
                                    studUnits."Student No." := "ACA-Course Registration"."Student No.";
                                    studUnits."Academic Year" := "ACA-Course Registration"."Academic Year";
                                    studUnits.Semester := "ACA-Course Registration".Semester;
                                    studUnits.Unit := unitsSUB.Code;
                                    studUnits."Reg. Transacton ID" := "ACA-Course Registration"."Reg. Transacton ID";
                                    studUnits.Stage := "ACA-Course Registration".Stage;
                                    studUnits."Unit Type" := studUnits."Unit Type"::Core;
                                    studUnits.Programme := "ACA-Course Registration".Programmes;
                                    studUnits."Unit Stage" := unitsSUB."Stage Code";
                                    studUnits.Insert();
                                until unitsSUB.Next() = 0;
                            end;


                        end;

                    until "ACA-Course Registration".Next() = 0;
                end;


            end;
        }
    }

    requestpage
    {

    }
    var
        myInt: Integer;
        unitsSUB: Record "ACA-Units/Subjects";
        studUnits: Record "ACA-Student Units";
}