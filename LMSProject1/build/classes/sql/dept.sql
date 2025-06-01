UPDATE dept
SET college = CASE
    WHEN dept_name IN ('Computer Science', 'Electrical Engineering', 'Mechanical Engineering') THEN 'College of Engineering'
    WHEN dept_name = 'Business Administration' THEN 'College of Business'
    WHEN dept_name IN ('Mathematics', 'Physics', 'Chemistry', 'Biology') THEN 'College of Science'
    WHEN dept_name IN ('English Literature', 'History') THEN 'College of Humanities'
    ELSE 'Unknown College' -- 미분류 학과에 대한 기본값
END;