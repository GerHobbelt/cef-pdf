// Copyright (c) 2021, Sebastian Pająk. MIT License.

#ifndef CEFPDF_JOB_STDINPUT_H_
#define CEFPDF_JOB_STDINPUT_H_

#include "Job.h"

namespace cefpdf {
namespace job {

class StdInput : public Job
{

public:
    virtual void accept(CefRefPtr<Visitor> visitor) override {
        visitor->visit(this);
    }

private:
    // Include the default reference counting implementation.
    IMPLEMENT_REFCOUNTING(StdInput);
};

} // namespace job
} // namespace cefpdf

#endif // CEFPDF_JOB_STDINPUT_H_
