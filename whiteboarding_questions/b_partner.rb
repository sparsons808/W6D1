SELECT
    employees.name
FROM
    employees
JOIN
    departments ON employees.deparment_id = deparments.id
WHERE
    deparments.name = given_name;

SELECT
    employees.name
FROM
    employees
WHERE
    employees.deparment_id IS NULL


# == Schema Information
#
# Table name: physicians
#
#  id   :integer          not null, primary key
#  name :string           not null


# Table name: appointments
#
#  id   :integer           not null, primary key
#  physician_id :integer   not null
#  patient_id :integer     not null


# Table name: patients
#
#  id   :integer           not null, primary key
#  name :string            not null
#  primary_physician_id :integer

class Physician < ApplicationRecord
    has_many :appointments,
        primary_key: :id,
        foreign_key: :physician_id,
        class_name: :Appointment

    has_many :primary_patients,
        primary_key: :id,
        foreign_key: :primary_physician_id,
        class_name: :Patient

    has_many :patients,
        through: :appointments,
        source: :patient

    has_many :primary_appointments,
        through: :primary_patients,
        source: :appointments
    
    
end

class Appointment < ApplicationRecord
    belongs_to :physician,
        primary_key: :id,
        foreign_key: :physician_id,
        class_name: :Physician

    belongs_to :patient,
        primary_key: :id,
        foreign_key: :patient_id,
        class_name: :Patient


end

class Patient < ApplicationRecord
    belongs_to :primary_physician,
        primary_key: :id,
        foreign_key: :primary_physician_id,
        class_name: :Physician

    has_many :appointments,
        primary_key: :id,
        foreign_key: :patient_id,
        class_name: :Appointment

end


# == Schema Information
#
# Table name: actors
#
#  id          :integer      not null, primary key
#  name        :string
#
# Table name: movies
#
#  id          :integer      not null, primary key
#  title       :string
#
# Table name: castings
#
#  movie_id    :integer      not null, primary key
#  actor_id    :integer      not null, primary key
#  ord         :integer

#-- 1. List the films where 'Harrison Ford' has appeared - but not in the star role.


SELECT
    movies.title
FROM
    movies
JOIN 
    castings ON movies.id = castings.movie_id
JOIN
    actors ON castings.actor_id = actors.id
WHERE 
    actors.name = 'Harrison Ford' AND castings.ord != 1;

#-- 2 -   Obtain a list in alphabetical order of actors who've had at least 15 starring roles.

SELECT
    actors.name
FROM
    actors
JOIN    
    castings ON actors.id = castings.actor_id
WHERE
    castings.ord = 1
GROUP BY
    actors.name
HAVING
    COUNT(*) >= 15
ORDER BY
    actors.name ASC
