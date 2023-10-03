package com.lab1.controllers;

import com.lab1.forms.TaskForm;
import com.lab1.models.Task;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import java.util.ArrayList;
import java.util.List;

@Slf4j
@Controller()
public class TaskController {
    private static final List<Task> tasks = new ArrayList<>();

    static {
        tasks.add(new Task(1, "1 + 1", "2"));
        tasks.add(new Task(2, "2 + 2", "4"));
        tasks.add(new Task(3, "3 + 3", "6"));
        tasks.add(new Task(4, "4 + 4", "8"));
        tasks.add(new Task(5, "5 + 5", "10"));
    }

    @Value("${welcome.message}")
    private String message;

    @Value("${error.message}")
    private String errorMessage;

    @GetMapping({"/", "/index"})
    public ModelAndView index(Model model) {
        var modelAndView = new ModelAndView("index");

        modelAndView.setViewName("index");
        model.addAttribute("message", message);

        log.info("was called index");
        return modelAndView;
    }

    @GetMapping("/tasks")
    public ModelAndView getTasks(Model model) {
        var modelAndView = new ModelAndView("tasks");

        modelAndView.setViewName("tasks");
        model.addAttribute("tasks", tasks);

        log.info("was called tasks");
        return modelAndView;
    }

    @GetMapping("/add-task")
    public ModelAndView getTaskForm(Model model) {
        var modelAndView = new ModelAndView("add-task-form");

        modelAndView.setViewName("add-task-form");
        model.addAttribute("taskform", new TaskForm());

        log.info("was called add-task");
        return modelAndView;
    }

    @PostMapping("/add")
    public ModelAndView submitTaskForm(Model model, @ModelAttribute("taskform") TaskForm taskForm) {
        if(taskForm.getAnswer().isEmpty() || taskForm.getCondition().isEmpty()) {
            var modelAndView = new ModelAndView("add-task-form");

            modelAndView.setViewName("add-task-form");
            model.addAttribute("errorMessage", errorMessage);

            log.info("was called add-task");
            return modelAndView;
        }
        Double rand = Math.random() % 2_000_000_000;
        int id = rand.intValue();
        taskForm.setId(id);

        tasks.add(taskForm);

        var modelAndView = new ModelAndView("tasks");

        modelAndView.setViewName("tasks");
        model.addAttribute("tasks", tasks);

        log.info("was called add-task");
        return modelAndView;
    }

    @GetMapping("/edit/{id}")
    public ModelAndView editForm(Model model, @PathVariable(value = "id", required = true) String _id) {
        var modelAndView = new ModelAndView("edit-task-form");

        modelAndView.setViewName("edit-task-form");
        int id = Integer.parseInt(_id);

        Task task = tasks.stream().filter(t -> t.getId() == id).findFirst().orElse(null);

        model.addAttribute("taskform", task);

        log.info("was called edit[GET]");
        return modelAndView;
    }
    @PostMapping("/edit")
    public ModelAndView edit(Model model, @ModelAttribute("taskform") TaskForm taskForm) {
        if(taskForm.getAnswer().isEmpty() || taskForm.getCondition().isEmpty()) {
            var modelAndView = new ModelAndView("edit-task-form");

            modelAndView.setViewName("edit-task-form");
            model.addAttribute("errorMessage", errorMessage);

            log.info("was called edit[POST]");
            return modelAndView;
        }

        for (Task task : tasks) {
            if (task.getId() == taskForm.getId()) {
                task.setCondition(taskForm.getCondition());
                task.setAnswer(taskForm.getAnswer());
            }
        }

        var modelAndView = new ModelAndView("tasks");

        modelAndView.setViewName("tasks");
        model.addAttribute("tasks", tasks);

        log.info("was called edit[POST]");
        return modelAndView;
    }

    @DeleteMapping("/delete/{id}")
    public ModelAndView delete(Model model, @PathVariable(value = "id", required = true) String _id) {
        var modelAndView = new ModelAndView("tasks");

        modelAndView.setViewName("tasks");
        int id = Integer.parseInt(_id);

        tasks.removeIf(t -> t.getId() == id);

        model.addAttribute("tasks", tasks);

        log.info("was called delete");
        return modelAndView;
    }
}
