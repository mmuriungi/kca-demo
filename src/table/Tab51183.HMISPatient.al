table 51183 "HMIS-Patient"
{
    //DrillDownPageID = "HMIS-Patient List";
    //LookupPageID = "HMIS-Patient List";

    fields
    {
        field(1; "Patient No."; Code[20])
        {
            DataClassification = ToBeClassified;
            NotBlank = true;

            trigger OnValidate()
            begin
                "First Name" := '';
                "Other Names" := '';
                Nationality := '';
                Religion := '';
                "Blood Group" := '';
                CLEAR(Picture);
                "ID/B.c. No./Passport no." := '';
                "Marrital Status" := '';
                Email := '';
                "Address 1" := '';
                "Address 2" := '';
                City := '';
                County := '';
                "First Registration Date" := 0D;
                Registered := FALSE;
                "Registered by" := '';
                Gender := '';
                "Date of Birth" := 0D;

                "Last Visit Date" := 0D;
                IF "Patient Category" = 'GENERAL' THEN BEGIN
                    IF HMISNoSeries.GET THEN BEGIN
                        HMISNoSeries.TESTFIELD("Patient Nos.");
                        "Patient No." := NoSeriesManagement.GetNextNo(HMISNoSeries."Patient Nos.", TODAY, TRUE);
                    END ELSE
                        ERROR('Number Series Setup for the hospital is missing');
                END ELSE
                    IF "Patient Category" = 'STUDENT' THEN BEGIN
                        Customer.RESET;
                        Customer.RESET;
                        Customer.SETRANGE("No.", "Patient No.");
                        IF Customer.FIND('-') THEN BEGIN
                            IF Customer.Image.HASVALUE THEN BEGIN
                                Customer.CALCFIELDS(Image);
                                //Rec.Picture := Customer.Picture;
                            END;
                            "First Name" := Customer.Name;
                            //  "Other Names":=GetOtherNames(Customer.Name);
                            "ID/B.c. No./Passport no." := Customer."ID No";
                            "Marrital Status" := FORMAT(Customer."Marital Status");
                            Email := Customer."E-Mail";
                            "Address 1" := Customer.Address;
                            "Address 2" := Customer."Address 2";
                            City := Customer.City;
                            County := Customer.County;
                            "First Registration Date" := TODAY;
                            "Date of Birth" := Customer."Date Of Birth";
                            Registered := TRUE;
                            "Registered by" := USERID;
                            Gender := FORMAT(Customer.Gender);
                            "Last Visit Date" := TODAY;
                        END;
                    END ELSE
                        IF ("Patient Category" IN ['DEPENDANTS', 'DEPENDANT', 'BENEFICIARIES', 'BENEFICIARY']) THEN BEGIN
                            HRMEmployeeBeneficiaries.RESET;
                            HRMEmployeeBeneficiaries.SETRANGE("ID No/Passport No", "Patient No.");
                            IF HRMEmployeeBeneficiaries.FIND('-') THEN BEGIN
                                "First Name" := HRMEmployeeBeneficiaries.SurName;
                                "Other Names" := HRMEmployeeBeneficiaries."Other Names";
                                "ID/B.c. No./Passport no." := HRMEmployeeBeneficiaries."ID No/Passport No";
                                //"Marrital Status":=FORMAT(HRMEmployeeC."Marital Status");
                                // Email:=HRMEmployeeC."E-Mail";
                                "Address 1" := HRMEmployeeBeneficiaries.Address;
                                //"Address 2":=HRMEmployeeC."Postal Address2";
                                "Date of Birth" := HRMEmployeeBeneficiaries."Date Of Birth";
                                // City:=HRMEmployeeC.City;
                                // County:=HRMEmployeeC.County;
                                "First Registration Date" := TODAY;
                                Registered := TRUE;
                                "Registered by" := USERID;
                                // Gender:=FORMAT(HRMEmployeeC.Gender);
                                "Last Visit Date" := TODAY;
                            END;
                        END ELSE BEGIN
                            HRMEmployeeC.RESET;
                            HRMEmployeeC.SETRANGE("No.", "Patient No.");
                            IF HRMEmployeeC.FIND('-') THEN BEGIN
                                IF HRMEmployeeC.Picture.HASVALUE THEN BEGIN
                                    HRMEmployeeC.CALCFIELDS(Picture);
                                    Rec.Picture := HRMEmployeeC.Picture;
                                END;
                                "First Name" := HRMEmployeeC."First Name";
                                "Other Names" := HRMEmployeeC."Middle Name" + ' ' + HRMEmployeeC."Last Name";
                                "ID/B.c. No./Passport no." := HRMEmployeeC."ID Number";
                                "Marrital Status" := FORMAT(HRMEmployeeC."Marital Status");
                                Email := HRMEmployeeC."E-Mail";
                                "Address 1" := HRMEmployeeC."Postal Address";
                                "Address 2" := HRMEmployeeC."Postal Address2";
                                "Date of Birth" := HRMEmployeeC."Date Of Birth";
                                City := HRMEmployeeC.City;
                                County := HRMEmployeeC.County;
                                "First Registration Date" := TODAY;
                                Registered := TRUE;
                                "Registered by" := USERID;
                                Gender := FORMAT(HRMEmployeeC.Gender);
                                "Last Visit Date" := TODAY;
                            END;
                        END;
            end;
        }
        field(2; "First Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Other Names"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "ID/B.c. No./Passport no."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Address 1"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Address 2"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(7; City; Text[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "HMIS-Central Setup Values".Code WHERE("Setup Group" = FILTER('CITIES'));
        }
        field(8; County; Code[50])
        {
            DataClassification = ToBeClassified;
            TableRelation = "HMIS-Central Setup Values".Code WHERE("Setup Group" = FILTER('COUNTY'));
        }
        field(9; "First Registration Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Registered by"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Last Visit Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Last Amission Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Number of Visits"; Integer)
        {
            // CalcFormula = Count("HMIS-Visits/Registrations" WHERE ("Patient No."=FIELD("Patient No.")));
            //FieldClass = FlowField;
        }
        field(14; "Last Weight"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(15; "Last Height"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(16; "Last Temperature"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(17; "Last Vitals Taken by"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(18; "Last BMI"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(20; Gender; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "HMIS-Central Setup Values".Code WHERE("Setup Group" = FILTER('GENDER'));
        }
        field(21; "Marrital Status"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "HMIS-Central Setup Values".Code WHERE("Setup Group" = FILTER('MARITAL STATUS'));
        }
        field(22; "Date of Birth"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(23; Picture; BLOB)
        {
            DataClassification = ToBeClassified;
            SubType = Bitmap;
        }
        field(24; Email; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(25; "Spouse Address 2"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(26; "Spouse Address 3"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(27; "Spouse Telephone No. 1"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(28; "Spouse Telephone No. 2"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(29; "Spouse Email"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(30; "Spouse Fax"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(31; "Place of Birth Village"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(32; "Place of Birth Location"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(33; "Place of Birth District"; Code[20])
        {
            DataClassification = ToBeClassified;
            //TableRelation = "ACA-Applic. Setup County".Code;
        }
        field(34; "Name of Chief"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(35; "Nearest Police Station"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(36; Nationality; Code[20])
        {
            DataClassification = ToBeClassified;
            //TableRelation = "HMIS-Central Setup Values".Code WHERE (Setup Group=FILTER(NATIONALITY));
        }
        field(37; Religion; Code[20])
        {
            DataClassification = ToBeClassified;
            // TableRelation = "HMIS-Central Setup Values".Code WHERE (Setup Group=FILTER(RELIGION));
        }
        field(38; "Mother Alive or Dead"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Alive,Deceased;
        }
        field(39; "Mother Full Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(40; "Mother Occupation"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(41; "Father Alive or Dead"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Alive,Deceased;
        }
        field(42; "Father Full Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(43; "Father Occupation"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(44; "Guardian Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(45; "Guardian Occupation"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(46; "Physical Impairment Details"; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(47; "Blood Group"; Code[20])
        {
            DataClassification = ToBeClassified;
            // TableRelation = "HMIS-Central Setup Values".Code WHERE (Setup Group=FILTER(BLOOD GROUP));
        }
        field(48; "Without Glasses R.6"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(49; "Without Glasses L.6"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50; "With Glasses R.6"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(51; "With Glasses L.6"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(52; "Hearing Right Ear"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(53; "Hearing Left Ear"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(54; "Condition Of Teeth"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(55; "Condition Of Throat"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(56; "Condition Of Ears"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(57; "Condition Of Lymphatic Glands"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(58; "Condition Of Nose"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(59; "Circulatory System Pulse"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(61; "Medical Exam Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(62; "Medical Details Not Covered"; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(63; "Emergency Consent Relationship"; Code[20])
        {
            DataClassification = ToBeClassified;
            NotBlank = true;
            TableRelation = Relative.Code;
        }
        field(64; "Emergency Consent Full Name"; Text[30])
        {
            DataClassification = ToBeClassified;
            NotBlank = true;
        }
        field(65; "Emergency Consent Address 1"; Text[30])
        {
            DataClassification = ToBeClassified;
            NotBlank = true;
        }
        field(66; "Emergency Consent Address 2"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(67; "Emergency Consent Address 3"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(68; "Emergency Date of Consent"; Date)
        {
            DataClassification = ToBeClassified;
            NotBlank = true;
        }
        field(69; "Emergency National ID Card No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Description = 'Stores the national identity card number of the person who consented to the emergency operation';
            NotBlank = true;
        }
        field(78; "Customer No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(85; Registered; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(89; "Depandant Principle Member"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "HRM-Employee C"."No.";
        }
        field(92; "Total Billed"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(94; "Fax No."; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(95; "Spouse Name"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(96; "Spouse Address 1"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(97; "Patient Category"; Code[20])
        {
            DataClassification = ToBeClassified;
            //TableRelation = "HMIS-Central Setup Values".Code WHERE (Setup Group=FILTER(PATIENT CATOGORIES));

            trigger OnValidate()
            begin
                // "First Name":='';
                //        "ID/B.c. No./Passport no.":='';
                //        "Marrital Status":='';
                //        Email:='';
                //        "Address 1":='';
                //        "Address 2":='';
                //        City:='';
                //        County:='';
                VALIDATE("Patient No.", '');
                //        "First Registration Date":=0D;
                //        Registered:=FALSE;
                //        "Registered by":='';
                //        Gender:='';
                //        "Date of Birth":=0D;
            end;
        }
        field(98; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'New,Active,Discharged/Released,Deceased';
            OptionMembers = New,Active,"Discharged/Released",Deceased;
        }
        field(99; "Master Patient Number"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(100; "is Depemndant"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Patient Category", "Patient No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        "First Name" := '';
        "ID/B.c. No./Passport no." := '';
        "Marrital Status" := '';
        Email := '';
        "Address 1" := '';
        "Address 2" := '';
        City := '';
        County := '';
        "First Registration Date" := 0D;
        Registered := FALSE;
        "Registered by" := '';
        Gender := '';
        "Date of Birth" := 0D;

        "Last Visit Date" := 0D;
        IF "Patient Category" = 'GENERAL' THEN BEGIN
            IF HMISNoSeries.GET THEN BEGIN
                HMISNoSeries.TESTFIELD("Patient Nos.");
                "Patient No." := NoSeriesManagement.GetNextNo(HMISNoSeries."Patient Nos.", TODAY, TRUE);
            END ELSE
                ERROR('Number Series Setup for the hospital is missing');
        END ELSE
            IF "Patient Category" = 'STUDENT' THEN BEGIN
                Customer.RESET;
                Customer.SETRANGE("No.", "Patient No.");
                IF Customer.FIND('-') THEN BEGIN
                    IF Customer.Image.HASVALUE THEN BEGIN
                        Customer.CALCFIELDS(Image);
                       // Rec.Picture := Customer.Picture;
                    END;
                    "First Name" := Customer.Name;
                    "ID/B.c. No./Passport no." := Customer."ID No";
                    "Marrital Status" := FORMAT(Customer."Marital Status");
                    Email := Customer."E-Mail";
                    "Address 1" := Customer.Address;
                    "Address 2" := Customer."Address 2";
                    City := Customer.City;
                    County := Customer.County;
                    "First Registration Date" := TODAY;
                    "Date of Birth" := Customer."Date Of Birth";
                    Registered := TRUE;
                    "Registered by" := USERID;
                    Gender := FORMAT(Customer.Gender);
                    "Last Visit Date" := TODAY;
                END;
            END ELSE BEGIN
                HRMEmployeeC.RESET;
                HRMEmployeeC.SETRANGE("No.", "Patient No.");
                IF HRMEmployeeC.FIND('-') THEN BEGIN
                    IF HRMEmployeeC.Picture.HASVALUE THEN BEGIN
                        HRMEmployeeC.CALCFIELDS(Picture);
                        Rec.Picture := HRMEmployeeC.Picture;
                    END;
                    "First Name" := HRMEmployeeC."First Name";
                    "Other Names" := HRMEmployeeC."Middle Name" + ' ' + HRMEmployeeC."Last Name";
                    "ID/B.c. No./Passport no." := HRMEmployeeC."ID Number";
                    "Marrital Status" := FORMAT(HRMEmployeeC."Marital Status");
                    Email := HRMEmployeeC."E-Mail";
                    "Address 1" := HRMEmployeeC."Postal Address";
                    "Address 2" := HRMEmployeeC."Postal Address2";
                    "Date of Birth" := HRMEmployeeC."Date Of Birth";
                    City := HRMEmployeeC.City;
                    County := HRMEmployeeC.County;
                    "First Registration Date" := TODAY;
                    Registered := TRUE;
                    "Registered by" := USERID;
                    Gender := FORMAT(HRMEmployeeC.Gender);
                    "Last Visit Date" := TODAY;
                END;
            END;
    end;

    trigger OnModify()
    begin
        "First Name" := '';
        "ID/B.c. No./Passport no." := '';
        "Marrital Status" := '';
        Email := '';
        "Address 1" := '';
        "Address 2" := '';
        City := '';
        County := '';
        "First Registration Date" := 0D;
        Registered := FALSE;
        "Registered by" := '';
        Gender := '';
        "Date of Birth" := 0D;

        "Last Visit Date" := 0D;
        IF "Patient Category" = 'GENERAL' THEN BEGIN
            IF HMISNoSeries.GET THEN BEGIN
                HMISNoSeries.TESTFIELD("Patient Nos.");
                "Patient No." := NoSeriesManagement.GetNextNo(HMISNoSeries."Patient Nos.", TODAY, TRUE);
            END ELSE
                ERROR('Number Series Setup for the hospital is missing');
        END ELSE
            IF "Patient Category" = 'STUDENT' THEN BEGIN
                Customer.RESET;
                Customer.SETRANGE("No.", "Patient No.");
                IF Customer.FIND('-') THEN BEGIN
                    IF Customer.Image.HASVALUE THEN BEGIN
                        Customer.CALCFIELDS(Image);
                        //Rec.Picture := Customer.Picture;
                    END;
                    "First Name" := Customer.Name;
                    "ID/B.c. No./Passport no." := Customer."ID No";
                    "Marrital Status" := FORMAT(Customer."Marital Status");
                    Email := Customer."E-Mail";
                    "Address 1" := Customer.Address;
                    "Address 2" := Customer."Address 2";
                    City := Customer.City;
                    County := Customer.County;
                    "First Registration Date" := TODAY;
                    "Date of Birth" := Customer."Date Of Birth";
                    Registered := TRUE;
                    "Registered by" := USERID;
                    Gender := FORMAT(Customer.Gender);
                    "Last Visit Date" := TODAY;
                END;
            END ELSE BEGIN
                HRMEmployeeC.RESET;
                HRMEmployeeC.SETRANGE("No.", "Patient No.");
                IF HRMEmployeeC.FIND('-') THEN BEGIN
                    IF HRMEmployeeC.Picture.HASVALUE THEN BEGIN
                        HRMEmployeeC.CALCFIELDS(Picture);
                        Rec.Picture := HRMEmployeeC.Picture;
                    END;
                    "First Name" := HRMEmployeeC."First Name";
                    "Other Names" := HRMEmployeeC."Middle Name" + ' ' + HRMEmployeeC."Last Name";
                    "ID/B.c. No./Passport no." := HRMEmployeeC."ID Number";
                    "Marrital Status" := FORMAT(HRMEmployeeC."Marital Status");
                    Email := HRMEmployeeC."E-Mail";
                    "Address 1" := HRMEmployeeC."Postal Address";
                    "Address 2" := HRMEmployeeC."Postal Address2";
                    "Date of Birth" := HRMEmployeeC."Date Of Birth";
                    City := HRMEmployeeC.City;
                    County := HRMEmployeeC.County;
                    "First Registration Date" := TODAY;
                    Registered := TRUE;
                    "Registered by" := USERID;
                    Gender := FORMAT(HRMEmployeeC.Gender);
                    "Last Visit Date" := TODAY;
                END;
            END;
    end;

    trigger OnRename()
    begin
        //ERROR('Rename is not allowed!');
    end;

    var
        HMISNoSeries: Record "HMIS-No. Series";
        NoSeriesManagement: Codeunit 396;
        Customer: Record 18;
        HRMEmployeeC: Record "HRM-Employee C";
        HRMEmployeeBeneficiaries: Record "HRM-Employee Beneficiaries";

    local procedure GetFirstName(FullNames: Text[250]) FirstName: Text[250]
    var
        CountedLoops: Integer;
        SpaceFound: Boolean;
    begin
        CLEAR(FirstName);
        CLEAR(CountedLoops);
        CLEAR(SpaceFound);
        REPEAT
        BEGIN
            CountedLoops := CountedLoops + 1;
            IF COPYSTR(FullNames, CountedLoops, 1) = ' ' THEN
                SpaceFound := TRUE ELSE
                IF (COPYSTR(FullNames, CountedLoops, 1) <> ' ') THEN
                    FirstName := FirstName + (COPYSTR(FullNames, CountedLoops, 1));
        END;
        UNTIL ((CountedLoops = STRLEN(FullNames)) OR (SpaceFound = TRUE));
    end;

    local procedure GetOtherNames(FullNames: Text[250]) OtherNames: Text[250]
    var
        CountedLoops: Integer;
        SpaceFound: Boolean;
        counted: Integer;
    begin
        CLEAR(OtherNames);
        CLEAR(CountedLoops);
        CLEAR(SpaceFound);
        CLEAR(counted);
        REPEAT
        BEGIN
            CountedLoops := CountedLoops + 1;
            IF SpaceFound = FALSE THEN
                IF COPYSTR(FullNames, CountedLoops, 1) = ' ' THEN BEGIN
                    SpaceFound := TRUE;//
                END;
            IF SpaceFound = TRUE THEN BEGIN
                // IF ((COPYSTR(FullNames,CountedLoops,1)<>' ')) THEN
                OtherNames := OtherNames + (COPYSTR(FullNames, CountedLoops, 1));
            END;
        END;
        UNTIL ((CountedLoops = STRLEN(FullNames)));
        IF STRLEN(OtherNames) > 1 THEN
            OtherNames := COPYSTR(OtherNames, 2, (STRLEN(OtherNames) - 1));
    end;
}

