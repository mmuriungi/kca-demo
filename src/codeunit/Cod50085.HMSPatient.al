codeunit 50085 "HMS Patient"
{

    trigger OnRun()
    begin
    end;

    var
        Employee: Record "HRM-Employee C";
        Relative: Record "HRM-Employee Kin";
        PatientRec: Record "HMS-Patient";
        NewPatientCode: Code[20];
        // NoSeriesMgt: Codeunit 396;
        HMSSetup: Record "HMS-Setup";
        Benf: Record "HRM-Employee Beneficiaries";


    //procedure CopyStudentToHMS(var Admission: Record 61372)
    // procedure CopyStudentToHMS()
    // var
    // Patient: Record 61402;
    // NoSeriesMgt: Codeunit 396;
    // HMSSetup: Record 61386;
    // NewCode: Code[20];
    //AdmMedicalCondition: Record 61376;
    //AdmImmunization: Record 61378;
    // PatMedicalCondition: Record 61435;
    // PatImmunization: Record 61436;
    // begin
    //     /*Check if the student is already registered in the system database*/
    //     Patient.RESET;
    //     Patient.SETRANGE(Patient."Student No.", Admission."Admission No.");
    //     IF Patient.FIND('-') THEN BEGIN
    //         //student already exists in the database
    //     END
    //     ELSE BEGIN
    // BEGIN
    //get the new patient number from the database
    /* HMSSetup.RESET;
    HMSSetup.GET();
    NewCode := NoSeriesMgt.GetNextNo(HMSSetup."Patient Nos", 0D, TRUE);
    //copy the details from  the admissions database and into the patient database
    Patient.INIT;
    Patient."Patient No." := NewCode;
    Patient."Date Registered" := TODAY;
    Patient."Patient Type" := Patient."Patient Type"::Others;
    Patient."Student No." := Admission."Admission No.";
    Patient.Surname := Admission.Surname;
    Patient."Middle Name" := Admission."Other Names";
    Patient.Gender := Admission.Gender;
    Patient."Date Of Birth" := Admission."Date Of Birth";
    Patient."Marital Status" := Admission."Marital Status";
    Patient.Photo := Admission.Photo;
    Patient."Correspondence Address 1" := Admission."Correspondence Address 1";
    Patient."Correspondence Address 2" := Admission."Correspondence Address 2";
    Patient."Correspondence Address 3" := Admission."Correspondence Address 3";
    Patient."Telephone No. 1" := Admission."Telephone No. 1";
    Patient."Telephone No. 2" := Admission."Telephone No. 2";
    Patient.Email := Admission."E-Mail";
    Patient."Fax No." := Admission."Fax No.";
    Patient."Spouse Name" := Admission."Spouse Name";
    Patient."Spouse Address 1" := Admission."Spouse Address 1";
    Patient."Spouse Address 2" := Admission."Spouse Address 2";
    Patient."Spouse Address 3" := Admission."Spouse Address 3";
    Patient."Place of Birth Village" := Admission."Place Of Birth Village";
    Patient."Place of Birth Location" := Admission."Place Of Birth Location";
    Patient."Place of Birth District" := Admission."Place Of Birth District";
    Patient."Name of Chief" := Admission."Name of Chief";
    Patient."Nearest Police Station" := Admission."Nearest Police Station";
    Patient.Nationality := Admission.Nationality;
    Patient.Religion := Admission.Religion;
    Patient."Mother Alive or Dead" := Admission."Mother Alive Or Dead";
    Patient."Mother Full Name" := Admission."Mother Full Name";
    Patient."Mother Occupation" := Admission."Mother Occupation";
    Patient."Father Alive or Dead" := Admission."Father Alive Or Dead";
    Patient."Father Full Name" := Admission."Father Full Name";
    Patient."Father Occupation" := Admission."Father Occupation";
    Patient."Guardian Name" := Admission."Guardian Full Name";
    Patient."Guardian Occupation" := Admission."Guardian Occupation";
    Patient."Physical Impairment Details" := Admission."Physical Impairment Details";
    Patient."Without Glasses R.6" := Admission."Without Glasses R.6";
    Patient."Without Glasses L.6" := Admission."Without Glasses L.6";
    Patient."With Glasses R.6" := Admission."With Glasses R.6";
    Patient."With Glasses L.6" := Admission."With Glasses L.6";
    Patient."Hearing Right Ear" := Admission."Hearing Right Ear";
    Patient."Hearing Left Ear" := Admission."Hearing Left Ear";
    Patient."Condition Of Teeth" := Admission."Condition Of Teeth";
    Patient."Condition Of Throat" := Admission."Condition Of Throat";
    Patient."Condition Of Ears" := Admission."Condition Of Ears";
    Patient."Condition Of Lymphatic Glands" := Admission."Condition Of Lymphatic Glands";
    Patient."Condition Of Nose" := Admission."Condition Of Nose";
    Patient."Circulatory System Pulse" := Admission."Circulatory System Pulse";
    Patient."Examining Officer" := Admission."Examining Officer";
    Patient."Medical Exam Date" := Admission."Medical Exam Date";
    Patient."Medical Details Not Covered" := Admission."Medical Details Not Covered";
    Patient."Emergency Consent Relationship" := Admission."Emergency Consent Relationship";
    Patient."Emergency Consent Full Name" := Admission."Emergency Consent Full Name";
    Patient."Emergency Consent Address 1" := Admission."Emergency Consent Address 1";
    Patient."Emergency Consent Address 2" := Admission."Emergency Consent Address 2";
    Patient."Emergency Consent Address 3" := Admission."Emergency Consent Address 3";
    Patient."Emergency Date of Consent" := Admission."Emergency Date of Consent";
    Patient."Emergency National ID Card No." := Admission."Emergency National ID Card No.";
    Patient.Height := Admission.Height;
    Patient.Weight := Admission.Weight;
    Patient.INSERT(); */
    /*Copy the medical condition from the database*/
    /* AdmMedicalCondition.RESET;
    AdmMedicalCondition.SETRANGE(AdmMedicalCondition."Admission No.", Admission."Admission No.");
    IF AdmMedicalCondition.FIND('-') THEN BEGIN
        REPEAT
            PatMedicalCondition.INIT;
            PatMedicalCondition."Patient No." := NewCode;
            PatMedicalCondition."Medical Condition" := AdmMedicalCondition."Medical Condition Code";
            PatMedicalCondition."Date From" := AdmMedicalCondition."Date From";
            PatMedicalCondition."Date To" := AdmMedicalCondition."Date To";
            PatMedicalCondition.Yes := AdmMedicalCondition.Yes;
            PatMedicalCondition.Details := AdmMedicalCondition.Details;
            PatMedicalCondition.INSERT;
        UNTIL AdmMedicalCondition.NEXT = 0; */
    //END;
    /*Copy the immunizations from the student admission database to the patient registration*/
    /* AdmImmunization.RESET;
    AdmImmunization.SETRANGE(AdmImmunization."Admission No.", Admission."Admission No.");
    IF AdmImmunization.FIND('-') THEN BEGIN
        REPEAT
            PatImmunization.INIT;
            PatImmunization."Patient No." := NewCode;
            PatImmunization."Immunization Code" := AdmImmunization."Immunization Code";
            PatImmunization.Yes := AdmImmunization.Yes;
            PatImmunization.Date := AdmImmunization.Date;
            PatImmunization.INSERT;
        UNTIL AdmImmunization.NEXT = 0;
    END; */
    //END;

    //end;


    // procedure CopyRegisteredStudentToHMS(var Student: Record "18")
    // var
    //     Patient: Record "61402";
    //     HMSSetup: Record "61386";
    //     NoSeriesMgt: Codeunit "396";
    //     NewCode: Code[20];
    // begin
    //     /*Check if the student is already a registered patient*/
    //     Patient.RESET;
    //     Patient.SETRANGE(Patient."Student No.", Student."No.");
    //     IF Patient.FIND('-') THEN BEGIN
    //         EXIT;
    //     END;

    //     HMSSetup.RESET;
    //     HMSSetup.GET();
    //     NewCode := NoSeriesMgt.GetNextNo(HMSSetup."Patient Nos", 0D, TRUE);
    //     Patient.INIT;
    //     Patient."Patient No." := NewCode;
    //     Patient."Patient Type" := Patient."Patient Type"::Student;
    //     Patient."Date Registered" := TODAY;
    //     Patient."Student No." := Student."No.";
    //     Patient.Surname := Student.Name;
    //     Patient.Gender := Student.Gender;
    //     Patient."Date Of Birth" := Student."Date Of Birth";
    //     Patient."Marital Status" := Student."Marital Status";
    //     Patient."ID Number" := Student."ID No";
    //     Patient.Photo := Student.Picture;
    //     Patient."Correspondence Address 1" := Student.Address;
    //     Patient."Correspondence Address 2" := Student."Address 2";
    //     Patient."Telephone No. 1" := Student."Phone No.";
    //     Patient."Fax No." := Student."Fax No.";
    //     Patient.Email := Student."E-Mail";
    //     Patient.Nationality := Student.Citizenship;
    //     Patient.Religion := Student.Religion;
    //     Patient.INSERT();

    // end;


    procedure CopyEmployeeToHMS()
    begin
        /*This function copies the employees from the hr module to the hospital management module*/
        Employee.RESET;
        IF Employee.FIND('-') THEN BEGIN
            REPEAT
                /*Check if the patient exists already in the database*/
                PatientRec.RESET;
                PatientRec.SETRANGE(PatientRec."Patient Type", PatientRec."Patient Type"::Employee);
                PatientRec.SETRANGE(PatientRec."Employee No.", Employee."No.");
                IF PatientRec.FIND('-') THEN BEGIN
                    /*Patient exists hence do nothing*/
                END
                ELSE BEGIN
                    /*Patient is new*/
                    HMSSetup.RESET;
                    HMSSetup.GET();
                    // NewPatientCode := NoSeriesMgt.GetNextNo(HMSSetup."Patient Nos", 0D, TRUE);
                    PatientRec.INIT;
                    PatientRec."Patient No." := NewPatientCode;
                    PatientRec."Patient Type" := PatientRec."Patient Type"::Employee;
                    PatientRec."Date Registered" := TODAY;
                    PatientRec."Employee No." := Employee."No.";
                    PatientRec.Title := FORMAT(Employee.Title);
                    PatientRec.Surname := Employee."First Name";
                    PatientRec."Middle Name" := Employee."Middle Name";
                    PatientRec."Last Name" := Employee."Last Name";
                    PatientRec.Gender := Employee.Gender;
                    PatientRec."Date Of Birth" := Employee."Date Of Birth";
                    PatientRec."Marital Status" := Employee."Marital Status";
                    PatientRec."ID Number" := Employee."ID Number";
                    PatientRec.Photo := Employee.Picture;
                    PatientRec.Email := Employee."E-Mail";
                    PatientRec."Telephone No. 1" := Employee."Home Phone Number" + ',' + Employee."Cellular Phone Number";
                    PatientRec."Telephone No. 2" := Employee."Work Phone Number" + ',' + Employee."Ext.";
                    PatientRec."Correspondence Address 1" := Employee."Postal Address";
                    PatientRec."Correspondence Address 2" := Employee."Residential Address";
                    PatientRec."Correspondence Address 3" := Employee.City + ',' + Employee."Post Code";
                    PatientRec."Fax No." := Employee."Fax Number";
                    PatientRec.INSERT();
                END;
            UNTIL Employee.NEXT = 0;
        END;

    end;


    procedure CopyDependantToHMS()
    begin
        /*This function copies the departments from the hr module to the hospital management module*/
        Relative.RESET;
        IF Relative.FIND('-') THEN BEGIN
            REPEAT
                /*Check if the patient exists already in the database*/
                PatientRec.RESET;
                PatientRec.SETRANGE(PatientRec."Patient Type", PatientRec."Patient Type"::Employee);
                PatientRec.SETRANGE(PatientRec."Employee No.", Relative."Employee Code");
                PatientRec.SETRANGE(PatientRec.Surname, Relative.SurName);
                PatientRec.SETRANGE(PatientRec."Last Name", Relative."Other Names");
                IF PatientRec.FIND('-') THEN BEGIN
                    /*Patient exists hence do nothing*/
                END
                ELSE BEGIN
                    /*Patient is new*/
                    HMSSetup.RESET;
                    HMSSetup.GET();
                    // NewPatientCode := NoSeriesMgt.GetNextNo(HMSSetup."Patient Nos", 0D, TRUE);
                    PatientRec.INIT;
                    PatientRec."Patient No." := NewPatientCode;
                    PatientRec."Patient Type" := PatientRec."Patient Type"::Dependant;
                    PatientRec."Date Registered" := TODAY;
                    PatientRec."Employee No." := Relative."Employee Code";
                    //          PatientRec."Relative No.":=Relative."Line No.";
                    PatientRec.Surname := Relative.SurName;
                    PatientRec."Last Name" := Relative."Other Names";
                    PatientRec."Telephone No. 1" := Relative."Office Tel No";
                    PatientRec."Telephone No. 2" := Relative."Home Tel No";
                    PatientRec."Correspondence Address 1" := Relative.Address;
                    //          PatientRec."Correspondence Address 2":=Relative."Postal Address2";
                    //        PatientRec."Correspondence Address 3":=Relative."Postal Address3";
                    PatientRec.Blocked := TRUE;
                    PatientRec.INSERT();
                END;
            UNTIL Relative.NEXT = 0;
        END;

    end;


    procedure CopyBeneficiarytToHMS()
    begin
        /*This function copies the departments from the hr module to the hospital management module*/
        Benf.RESET;
        IF Benf.FIND('-') THEN BEGIN
            REPEAT
                /*Check if the patient exists already in the database*/
                PatientRec.RESET;
                PatientRec.SETRANGE(PatientRec."Patient Type", PatientRec."Patient Type"::Employee);
                PatientRec.SETRANGE(PatientRec."Employee No.", Benf."Employee Code");
                PatientRec.SETRANGE(PatientRec.Surname, Benf.SurName);
                PatientRec.SETRANGE(PatientRec."Last Name", Benf."Other Names");
                IF PatientRec.FIND('-') THEN BEGIN
                    /*Patient exists hence do nothing*/
                END
                ELSE BEGIN
                    /*Patient is new*/
                    HMSSetup.RESET;
                    HMSSetup.GET();
                    //NewPatientCode := NoSeriesMgt.GetNextNo(HMSSetup."Patient Nos", 0D, TRUE);
                    PatientRec.INIT;
                    PatientRec."Patient No." := NewPatientCode;
                    PatientRec."Patient Type" := PatientRec."Patient Type"::Dependant;
                    PatientRec."Date Registered" := TODAY;
                    PatientRec."Employee No." := Benf."Employee Code";
                    //          PatientRec."Relative No.":=Relative."Line No.";
                    PatientRec.Surname := Benf.SurName;
                    PatientRec."Last Name" := Benf."Other Names";
                    PatientRec."Telephone No. 1" := Benf."Office Tel No";
                    PatientRec."Telephone No. 2" := Benf."Home Tel No";
                    PatientRec."Correspondence Address 1" := Benf.Address;
                    PatientRec."Date Of Birth" := Benf."Date Of Birth";
                    //PatientRec."Correspondence Address 2":=Relative."Postal Address2";
                    //
                    //PatientRec."Correspondence Address 3":=Relative."Postal Address3";
                    PatientRec.Blocked := TRUE;
                    PatientRec.INSERT();
                END;
            UNTIL Benf.NEXT = 0;
        END;

    end;
}

