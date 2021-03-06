package com.greenfoxacademy.petpal.animal.models;

import com.greenfoxacademy.petpal.users.models.PrivateUser;
import com.greenfoxacademy.petpal.users.models.SuperUser;
import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;
import java.sql.Timestamp;
import java.util.Set;

@Entity
@Inheritance(strategy = InheritanceType.SINGLE_TABLE)
@DiscriminatorColumn(name = "animal_type")
@Getter
@Setter
public abstract class Animal {

  @Id
  @GeneratedValue(strategy = GenerationType.IDENTITY)
  private Long id;
  private String name;
  private Timestamp birthDate;
  private String type;
  private String gender;
  private Timestamp fromWhenAvailable;
  private String photoPath;
  private Boolean spayed;
  private Boolean vaccinated;
  private Boolean adopted;

  @ManyToMany
  @JoinTable(
          name = "private_users_liked_animals",
          joinColumns = @JoinColumn(
                  name = "animal_id", referencedColumnName = "id"),
          inverseJoinColumns = @JoinColumn(
                  name = "private_user_id", referencedColumnName = "id"))
  private Set<PrivateUser> privateUser;

  /*@ManyToOne
  @JoinColumn(name = "private_user_id", referencedColumnName = "id")
  private PrivateUser privateUserAdopt;*/

  @ManyToOne
  @JoinColumn(name = "super_user_id", referencedColumnName = "id")
  private SuperUser superUser;

  protected Long getAge() {
    return 0L;
  }
}
